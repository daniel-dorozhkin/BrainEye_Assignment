//
//  ScoreSectionCellViewModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

import Foundation

protocol ScoreSectionCellViewModelProtocol {
    var graphHeaderTitle: String { get }
    var graphDateRangeTitle: String { get }
    var graphViewModel: GraphViewModel<ScoreSectionModel.ScorePointModel> { get }
    
    var averageScoreTitle: String { get }
    var latestScoreTitle: String { get }
    var rangeScoreTitle: String { get }
}

final class ScoreSectionCellViewModel: ScoreSectionCellViewModelProtocol {
    
    // MARK: - Properties
    private let model: ScoreSectionModel
    
    var graphHeaderTitle: String { getGraphHeaderTitle() }
    var graphDateRangeTitle: String { getGraphDateRangeTitle() }
    var graphViewModel: GraphViewModel<ScoreSectionModel.ScorePointModel> {
        getGraphViewModel()
    }
    
    var averageScoreTitle: String { getAverageScoreTitle() }
    var latestScoreTitle: String { getLatestScoreTitle() }
    var rangeScoreTitle: String { getScoreRangeTitle() }
    
    // MARK: - Init
    init(model: ScoreSectionModel) {
        self.model = model
    }
    
    // MARK: - Average score
    private func getAverageScoreTitle() -> String {
        return "\(model.averageInsightValue) \(model.scoreUnit.symbol)"
    }
    
    // MARK: - Latest score
    private func getLatestScoreTitle() -> String {
        return "\(model.latestInsightValue) \(model.scoreUnit.symbol)"
    }
    
    // MARK: - Range score
    private func getScoreRangeTitle() -> String {
        return "\(model.insightRange.lowerBound)-\(model.insightRange.upperBound) \(model.scoreUnit.symbol)"
    }
    
    // MARK: - Graph model
    private func getGraphViewModel() -> GraphViewModel<ScoreSectionModel.ScorePointModel> {
        return GraphViewModel(
            areaRange: model.normalRange,
            areaTitle: "Normal range",
            unitSymbol: model.scoreUnit.symbol,
            source: model.scores
        )
    }
    
    // MARK: - Graph date range
    private func getGraphDateRangeTitle() -> String {
        guard let endDate = model.scores.sorted(by: {
            $0.date < $1.date }
        ).last?.date
        else { return "" }
        
        let startDate = model.startDate
        let startMonth = startDate.monthString
        let endMonth = endDate.monthString
        let endYear = endDate.yearString
        
        return "\(startMonth) - \(endMonth) \(endYear)"
    }
    
    // MARK: - Graph header
    private func getGraphHeaderTitle() -> String {
        let sectionTitle = model.scoreType.title
        let unitSymbol = model.scoreUnit.symbol
        return "\(sectionTitle) (\(unitSymbol))"
    }
}
