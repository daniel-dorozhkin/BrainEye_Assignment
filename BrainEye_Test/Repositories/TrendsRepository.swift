//
//  TrendsRepository.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//
import Foundation

protocol TrendsRepositoryProtocol {
    func fetchScoreSections() -> Result<[ScoreSectionModel], ApiError>
}

final class TrendsRepository: TrendsRepositoryProtocol {
    
    // MARK: - Properties
    private let apiClient: TrendsApiClientProtocol
    
    // MARK: - Init
    init(apiClient: TrendsApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    func fetchScoreSections() -> Result<[ScoreSectionModel], ApiError> {
        return apiClient.fetchScoreSectionModels().flatMap { response in
            let sectionModels = getSectionModels(from: response)
            return .success(sectionModels)
        }
    }
    
    // MARK: - Private methods
    private func getSectionModels(from response: [ScoreDataResponseModel]) -> [ScoreSectionModel] {
        return response.map({
            let scores = getScorePointModel(from: $0)
            let normalRange = getNormalRange(from: $0)
            let startDate = getStartDate(from: $0)
            let unit = getScoreUnit(from: $0)
            let type = getScoreType(from: $0)
            
            return ScoreSectionModel(
                scoreUnit: unit,
                scoreType: type,
                scores: scores,
                normalRange: normalRange,
                insightRange: $0.insight.range.lowerBound...$0.insight.range.upperBound,
                averageInsightValue: $0.insight.average,
                latestInsightValue: $0.insight.latest,
                startDate: startDate
            )
        })
    }
    
    private func getScorePointModel(from response: ScoreDataResponseModel) -> [ScoreSectionModel.ScorePointModel] {
        return response.scorePoints.map({
            .init(
                score: $0.value,
                date: Date(timeIntervalSince1970: $0.timestamp)
            )
        })
    }
    
    private func getNormalRange(from response: ScoreDataResponseModel) -> ClosedRange<Int> {
        guard let rangeModel = response.normalRanges.first else { return 0...0 }
        let range = rangeModel.range
        return range.lowerBound...range.upperBound
    }
    
    private func getStartDate(from response: ScoreDataResponseModel) -> Date {
        let startScoreDate = response.scorePoints.first?.timestamp ?? Date().timeIntervalSince1970
        guard let normalRange = response.normalRanges.first else {
            return Date(timeIntervalSince1970: startScoreDate)
        }
        
        return Date(timeIntervalSince1970: normalRange.startDate)
    }
    
    private func getScoreUnit(from response: ScoreDataResponseModel) -> ScoreSectionModel.ScoreUnit {
        switch response.unit {
        case .percentage:
            return .percentage
        case .milliseconds:
            return .milliseconds
        }
    }
    
    private func getScoreType(from response: ScoreDataResponseModel) -> ScoreSectionModel.ScoreType {
        switch response.scoreType {
        case .accuracy:
            return .accuracy
        case .reactionTime:
            return .reactionTime
        }
    }
}
