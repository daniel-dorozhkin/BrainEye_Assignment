//
//  CustomNavigationController.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

protocol CustomNavigationControllerDelegate: AnyObject {
    func backButtonTapped()
}

final class CustomNavigationController: UINavigationController, CustomNavigationBarDelegate {
    
    // MARK: - Properties
    weak var navigationDelegate: CustomNavigationControllerDelegate?
    private lazy var customNavigationBar: CustomNavigationBarProtocol = {
        return CustomNavigationBarView(delegate: self)
    }()
    
    // MARK: - Public methods
    override func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        if animated {
            customNavigationBar.animateHidding(isHidden: isHidden)
            return
        }
        
        customNavigationBar.isHidden = isHidden
    }
    
    func setNavigationBarTitle(_ title: String) {
        customNavigationBar.setNavigationBarTitle(title)
    }
    
    func setBackButton(isHidden: Bool) {
        customNavigationBar.setBackButton(isHidden: isHidden)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePresentedViewControllerSafeArea()
    }
    
    // MARK: - User actions
    func backButtonTapped() {
        navigationDelegate?.backButtonTapped()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        super.setNavigationBarHidden(true, animated: false)
        self.view.addSubview(customNavigationBar)
        addSafeAreaSpacer()
        
        let navigationBarHeight = min((view.frame.height * 0.1), 76.0)
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(
                equalToConstant: navigationBarHeight)
        ])
        
        customNavigationBar.layer.cornerRadius = 25.0
        customNavigationBar.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    private func updatePresentedViewControllerSafeArea() {
        topViewController?.additionalSafeAreaInsets = UIEdgeInsets(
            top: customNavigationBar.frame.height,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    private func addSafeAreaSpacer() {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.backgroundColor = Asset.Colors.grayDark.color
        self.view.addSubview(spacer)
        
        NSLayoutConstraint.activate([
            spacer.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            spacer.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            spacer.topAnchor.constraint(
                equalTo: view.topAnchor),
            spacer.bottomAnchor.constraint(
                equalTo: customNavigationBar.topAnchor)
        ])
    }
}
