//
//  TrendsDataResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct TrendsDataResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case trends = "trends"
    }
    
    let trends: [ScoreDataResponseModel]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trends = try container.decode([ScoreDataResponseModel].self, forKey: .trends)
    }
}
