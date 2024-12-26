//
//  AppCoordinator.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

protocol AppCoordinatorProtocol: BaseCoordinatorProtocol {
    func closeApp()
}

final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
    
    // MARK: Public methods
    override func start() {
        let trendsScreen = makeTrendsScreen()
        push(trendsScreen)
    }
    
    func closeApp() {
        UIControl().sendAction(
            #selector(NSXPCConnection.suspend),
            to: UIApplication.shared,
            for: nil
        )
    }
    
    // MARK: - Private methods
    private func makeTrendsScreen() -> UIViewController {
        let apiClient = TrendsApiClient()
        let repository = TrendsRepository(apiClient: apiClient)
        let viewModel = TrendsScreenViewModel(coordinator: self, repository: repository)
        return TrendsScreenViewController(viewModel: viewModel)
    }
}
