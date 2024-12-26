//
//  UIViewController+NavigationController.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

extension UIViewController {
    var customNavigationController: CustomNavigationController? {
        return navigationController as? CustomNavigationController
    }
}
