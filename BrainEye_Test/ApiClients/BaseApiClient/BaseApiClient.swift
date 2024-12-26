//
//  BaseApiClient.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//
import Foundation

class BaseApiClient {
    final func fetch<T: Decodable>(from endpoint: ApiEndpoint) -> Result<T, ApiError> {
        guard let url = buildUrl(from: endpoint) else { return .failure(.fileNotFound) }
        
        do {
            let data = try Data(contentsOf: url)
            let response: T = try decode(data)
            return .success(response)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    // MARK: - Private methods
    private func buildUrl(from endpoint: ApiEndpoint) -> URL? {
        return Bundle.main.url(
            forResource: endpoint.fileName,
            withExtension: endpoint.fileExtension
        )
    }
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
