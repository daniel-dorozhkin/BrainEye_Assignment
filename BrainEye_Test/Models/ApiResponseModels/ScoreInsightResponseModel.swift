//
//  ScoreInsightResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct ScoreInsightResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case range = "range"
        case average = "average"
        case latest = "latest"
    }
    
    let range: ScoreRangeResponseModel
    let average: Int
    let latest: Int
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.range = try container.decode(ScoreRangeResponseModel.self, forKey: .range)
        self.average = try container.decode(Int.self, forKey: .average)
        self.latest = try container.decode(Int.self, forKey: .latest)
    }
}
