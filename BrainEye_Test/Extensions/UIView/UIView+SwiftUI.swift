//
//  UIView+SwiftUI.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 23/12/2024.
//

import UIKit
import SwiftUI

extension UIView {
    func addSwiftUI<Content: View>(view: Content) {
        let hosting = UIHostingController(rootView: view)
        hosting.view.frame = bounds
        hosting.view.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        
        addSubview(hosting.view)
    }
}
