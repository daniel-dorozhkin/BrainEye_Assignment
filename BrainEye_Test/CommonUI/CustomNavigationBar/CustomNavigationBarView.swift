//
//  CustomToolbarView.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

protocol CustomNavigationBarProtocol: UIView {
    func setBackButton(isHidden: Bool)
    func setNavigationBarTitle(_ title: String)
}

protocol CustomNavigationBarDelegate: AnyObject {
    func backButtonTapped()
}

final class CustomNavigationBarView: UIView, CustomNavigationBarProtocol {
    
    // MARK: - Properties
    private let headerLabel: UILabel = makeHeaderLabel()
    private let backButton: UIButton = makeBackButton()
    private weak var delegate: CustomNavigationBarDelegate?
    
    // MARK: - Init
    init(delegate: CustomNavigationBarDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setBackButton(isHidden: Bool) {
        self.backButton.isHidden = isHidden
    }
    
    func setNavigationBarTitle(_ title: String) {
        self.headerLabel.text = title
    }
    
    // MARK: - User action
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        self.backgroundColor = Asset.Colors.grayDark.color
        
        addSubview(backButton)
        addSubview(headerLabel)
        
        backButtonConfigure()
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16.0),
            
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: trailingAnchor,
                constant: -49.0)
        ])
    }
    
    // MARK: - Header label
    static private func makeHeaderLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontConstants.heading1
        label.textColor = Asset.Colors.textWhite.color
        label.textAlignment = .center
        return label
    }
    
    // MARK: - Back button
    static private func makeBackButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.Icons.backArrow.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    private func backButtonConfigure() {
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 32.0),
            backButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])
    }
    
}
