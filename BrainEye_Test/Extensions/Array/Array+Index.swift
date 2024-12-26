//
//  Array+Index.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 25/12/2024.
//

extension Collection  {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
