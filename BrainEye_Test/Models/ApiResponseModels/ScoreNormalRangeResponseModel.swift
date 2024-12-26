//
//  ScoreNormalRangeResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct ScoreNormalRangeResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case range = "range"
        case startDate = "start_date"
    }
    
    let range: ScoreRangeResponseModel
    let startDate: Double
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.range = try container.decode(ScoreRangeResponseModel.self, forKey: .range)
        self.startDate = try container.decode(Double.self, forKey: .startDate)
    }
}
