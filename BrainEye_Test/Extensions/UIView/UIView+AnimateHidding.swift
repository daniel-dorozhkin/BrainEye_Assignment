//
//  UIView+AnimateHidding.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

extension UIView {
    func animateHidding(isHidden: Bool,
                        duration: TimeInterval = 0.25,
                        completion: (() -> Void)? = nil) {
        self.alpha = isHidden ? 0 : 1
        UIView.animate(
            withDuration: duration,
            animations: {
                self.alpha = isHidden ? 0 : 1
            },
            completion: { _ in
                self.isHidden = isHidden
                completion?()
            }
        )
    }
}
