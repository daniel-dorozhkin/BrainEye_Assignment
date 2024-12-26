//
//  FontConstants.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

struct FontConstants {
    private typealias NunitoSans = FontFamily.NunitoSans
    static let heading1 = NunitoSans.bold.font(size: 24)
    static let heading6 = NunitoSans.bold.font(size: 20)
    
    static let body2 = NunitoSans.bold.font(size: 16)
    static let body3 = NunitoSans.regular.font(size: 12)
}
