//
//  Date+String.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 22/12/2024.
//

import Foundation

extension Date {
    var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
    
    var yearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
}
