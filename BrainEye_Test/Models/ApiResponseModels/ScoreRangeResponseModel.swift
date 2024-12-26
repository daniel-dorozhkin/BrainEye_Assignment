//
//  ScoreRangeResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct ScoreRangeResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case lowerBound = "lower_bound"
        case upperBound = "upper_bound"
    }
    
    let lowerBound: Int
    let upperBound: Int
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lowerBound = try container.decode(Int.self, forKey: .lowerBound)
        self.upperBound = try container.decode(Int.self, forKey: .upperBound)
    }
}
