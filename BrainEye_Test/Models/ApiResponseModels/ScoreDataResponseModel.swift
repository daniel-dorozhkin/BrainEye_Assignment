//
//  ScoreDataResponseModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//

struct ScoreDataResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case scoreType = "score_type"
        case unit = "unit"
        case scoreRange = "score_range"
        case normalRanges = "normal_ranges"
        case insight = "insight"
        case scorePoints = "score_points"
    }
    
    let scoreType: ScoreTypeResponseModel
    let unit: ScoreUnitResponseModel
    let scoreRange: ScoreRangeResponseModel
    let normalRanges: [ScoreNormalRangeResponseModel]
    let insight: ScoreInsightResponseModel
    let scorePoints: [ScorePointResponseModel]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scoreType = try container.decode(ScoreTypeResponseModel.self, forKey: .scoreType)
        self.unit = try container.decode(ScoreUnitResponseModel.self, forKey: .unit)
        self.scoreRange = try container.decode(ScoreRangeResponseModel.self, forKey: .scoreRange)
        self.normalRanges = try container.decode([ScoreNormalRangeResponseModel].self, forKey: .normalRanges)
        self.insight = try container.decode(ScoreInsightResponseModel.self, forKey: .insight)
        self.scorePoints = try container.decode([ScorePointResponseModel].self, forKey: .scorePoints)
    }
}
