//
//  ScorePointResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct ScorePointResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case timestamp = "timestamp"
    }
    
    let value: Int
    let timestamp: Double
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Int.self, forKey: .value)
        self.timestamp = try container.decode(Double.self, forKey: .timestamp)
    }
}
