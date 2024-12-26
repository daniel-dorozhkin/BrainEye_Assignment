//
//  UIView+Pin.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

extension UIView {
    func pinSuperview(
        leading: CGFloat = 0.0,
        trailing: CGFloat = 0.0,
        top: CGFloat = 0.0,
        bottom: CGFloat = 0.0) {
            guard let superview else { return }
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(
                    equalTo: superview.leadingAnchor,
                    constant: leading),
                trailingAnchor.constraint(
                    equalTo: superview.trailingAnchor,
                    constant: trailing),
                topAnchor.constraint(
                    equalTo: superview.topAnchor,
                    constant: top),
                bottomAnchor.constraint(
                    equalTo: superview.bottomAnchor,
                    constant: bottom)
            ])
        }
}
