//
//  GraphViewModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 21/12/2024.
//
import Foundation

protocol GraphDataRepresentable: Identifiable {
    var xValue: Date { get }
    var yValue: Int { get }
}

struct GraphViewModel<T: GraphDataRepresentable> {
    
    // MARK: - Properties
    let areaRange: Range<Double>
    let areaTitle: String
    let unitSymbol: String
    let source: [T]
    
    // MARK: - Init
    init(areaRange: ClosedRange<Int>,
         areaTitle: String,
         unitSymbol: String,
         source: [T]) {
        self.unitSymbol = unitSymbol
        self.source = source
        self.areaTitle = areaTitle
        self.areaRange = .init(
            uncheckedBounds: (
                lower: Double(areaRange.lowerBound),
                upper: Double(areaRange.upperBound)
            )
        )
    }
}
