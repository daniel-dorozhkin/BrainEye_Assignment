//
//  TrendsApiClient.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

import Foundation

protocol TrendsApiClientProtocol {
    func fetchScoreSectionModels() -> Result<[ScoreDataResponseModel], ApiError>
}

final class TrendsApiClient: BaseApiClient, TrendsApiClientProtocol {
    func fetchScoreSectionModels() -> Result<[ScoreDataResponseModel], ApiError> {
        let result: Result<TrendsDataResponseModel, ApiError> = fetch(from: .getTrends)
        switch result {
        case .success(let response):
            return .success(response.trends)
        case .failure(let error):
            return .failure(error)
        }
    }
}
