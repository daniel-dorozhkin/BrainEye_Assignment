//
//  BaseCoordinator.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

protocol BaseCoordinatorProtocol: BaseCoordinator { }

class BaseCoordinator {
    
    // MARK: - Properties
    private(set) var navigationController: CustomNavigationController
    
    // MARK: - Init
    init(navigationController: CustomNavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    func start() {
        assertionFailure("Subclasses must implement start method")
    }
    
    final func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @discardableResult
    final func popViewController() -> UIViewController? {
        navigationController.popViewController(animated: true)
    }
    
    @discardableResult
    final func popTo(_ viewController: UIViewController) -> [UIViewController]? {
        navigationController.popToViewController(viewController, animated: true)
    }
    
    @discardableResult
    final func popToRoot() -> [UIViewController]? {
        navigationController.popToRootViewController(animated: true)
    }
}
