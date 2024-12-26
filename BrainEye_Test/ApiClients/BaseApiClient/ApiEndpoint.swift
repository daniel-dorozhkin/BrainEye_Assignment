//
//  ApiEndpoint.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 25/12/2024.
//

enum ApiEndpoint {
    case getTrends
    
    var fileName: String {
        switch self {
        case .getTrends:
            return "Snippet"
        }
    }
    
    var fileExtension: String {
        switch self {
        case .getTrends:
            return "json"
        }
    }
}
