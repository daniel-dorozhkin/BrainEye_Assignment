//
//  ScoreSectionModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//
import Foundation

struct ScoreSectionModel {
    
    // MARK: - Properties
    let scoreUnit: ScoreUnit
    let scoreType: ScoreType
    let scores: [ScorePointModel]
    
    let normalRange: ClosedRange<Int>
    let insightRange: ClosedRange<Int>
    
    let averageInsightValue: Int
    let latestInsightValue: Int
    
    let startDate: Date
    
    // MARK: - Init
    init(scoreUnit: ScoreUnit,
         scoreType: ScoreType,
         scores: [ScorePointModel],
         normalRange: ClosedRange<Int>,
         insightRange: ClosedRange<Int>,
         averageInsightValue: Int,
         latestInsightValue: Int,
         startDate: Date) {
        self.scoreUnit = scoreUnit
        self.scoreType = scoreType
        self.scores = scores
        self.normalRange = normalRange
        self.insightRange = insightRange
        self.averageInsightValue = averageInsightValue
        self.latestInsightValue = latestInsightValue
        self.startDate = startDate
    }
}

// MARK: - Score unit
extension ScoreSectionModel {
    enum ScoreUnit {
        case percentage
        case milliseconds
        
        var symbol: String {
            switch self {
            case .percentage:
                return "%"
            case .milliseconds:
                return "ms"
            }
        }
    }
}

// MARK: - Score type
extension ScoreSectionModel {
    enum ScoreType {
        case accuracy
        case reactionTime
        
        var title: String {
            switch self {
            case .accuracy:
                return "Accuracy"
            case .reactionTime:
                return "Reaction Time"
            }
        }
    }
}

// MARK: - Score point model
extension ScoreSectionModel {
    struct ScorePointModel: GraphDataRepresentable {
        let id = UUID()
        let score: Int
        let date: Date
        
        var xValue: Date { return date }
        var yValue: Int { return score }
    }
}
