//
//  ScoreInsightsView.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 24/12/2024.
//

import UIKit
 
final class ScoreInsightsView: UIView {
    
    // MARK: - Properties
    private lazy var contentStackView = makeStackContentView()
    
    private(set) lazy var latestScoreLabel = makeLabel()
    private(set) lazy var averageScoreLabel = makeLabel()
    private(set) lazy var rangeScoreLabel = makeLabel()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        self.layer.cornerRadius = 15.0
        self.backgroundColor = Asset.Colors.grayDark.color
        
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            contentStackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 16.0),
            contentStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 2.0),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSections()
        configureLabelsUI()
    }
    
    // MARK: - Section
    private func addSections() {
        contentStackView.addArrangedSubview(
            makeVerticalSection(
                headerText: Constants.latestSectionHeader,
                label: latestScoreLabel
            )
        )
        
        contentStackView.addArrangedSubview(makeSeparatorView())
        contentStackView.addArrangedSubview(
            makeVerticalSection(
                headerText: Constants.averageSectionHeader,
                label: averageScoreLabel
            )
        )
        
        contentStackView.addArrangedSubview(makeSeparatorView())
        contentStackView.addArrangedSubview(
            makeVerticalSection(
                headerText: Constants.rangeSectionHeader,
                label: rangeScoreLabel
            )
        )
    }
    
    private func makeVerticalSection(headerText: String, label: UILabel) -> UIView {
        let container = UIView()
        let stackView = makeVerticalSectionStackView(headerText: headerText, label: label)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -12)
        ])
        return container
    }
    
    private func makeVerticalSectionStackView(headerText: String, label: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        let header = makeLabel()
        header.text = headerText
        header.font = FontConstants.body3
        header.textColor = Asset.Colors.textWhite.color.withAlphaComponent(0.6)
        
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    // MARK: - Stack content view
    private func makeStackContentView() -> UIStackView {
        let stackContentView = UIStackView()
        stackContentView.translatesAutoresizingMaskIntoConstraints = false
        stackContentView.axis = .horizontal
        stackContentView.alignment = .fill
        stackContentView.distribution = .fillProportionally
        return stackContentView
    }
    
    private func makeStackViewSpacer(width: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width)
        ])
        return view
    }
    
    // MARK: - Separator view
    private func makeSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Asset.Colors.grayLight.color
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalToConstant: 1.0),
        ])
        return separatorView
    }
    
    // MARK: - Label
    private func configureLabelsUI() {
        let scoreLabels = [latestScoreLabel, rangeScoreLabel, averageScoreLabel]
        scoreLabels.forEach {
            $0.textColor = Asset.Colors.textWhite.color
            $0.font = FontConstants.heading6
        }
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - Constants
private extension ScoreInsightsView {
    struct Constants {
        static let latestSectionHeader = "Latest"
        static let averageSectionHeader = "Average"
        static let rangeSectionHeader = "Range"
    }
}
