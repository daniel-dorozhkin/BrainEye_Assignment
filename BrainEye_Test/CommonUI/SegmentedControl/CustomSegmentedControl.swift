//
//  CustomSegmentedControl.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControl<T>(didSelectSegment segment: T, at index: Int)
    func segmentedControl<T>(titleFor segment: T, at index: Int) -> String
}

final class CustomSegmentedControl<T>: UIView {
    
    // MARK: - Properties
    weak var delegate: CustomSegmentedControlDelegate?
    
    private var buttons: [UIButton] = []
    private lazy var indicatorView: UIView = makeIndicatorView()
    private lazy var contentStackView: UIStackView = makeContentStackView()
    
    private let indicatorColor = Asset.Colors.backgroundBlue.color
    private let textColor = Asset.Colors.textWhite.color
    
    private var selectedIndex: Int = 0
    var segments: [T] = [] {
        didSet {
            configureView()
        }
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicatorPosition()
    }
    
    // MARK: - Public methods
    func setSelectedIndex(_ index: Int) {
        guard index != selectedIndex else { return }
        selectedIndex = index
    }
    
    func animateIndicatorPosition(_ position: CGFloat) {
        let selectedButton = buttons[selectedIndex]
        let delta = position - CGFloat(selectedIndex)
        let offset = selectedButton.frame.width * abs(delta)
        
        let direction = CGFloat((delta < 0) ? -1 : 1)
        let newFrame = selectedButton.frame.offsetBy(
            dx: offset * direction,
            dy: 0
        )
        
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.frame = newFrame
        }
    }
    
    // MARK: - UI Configure
    private func configureView() {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        clearViewIfNeeded()
        guard !(segments.isEmpty) else { return }
        
        setupStackView()
        contentStackView.addSubview(indicatorView)
        addButtons()
        
        layoutIfNeeded()
        updateIndicatorPosition()
    }
    
    // MARK: - UI Update
    private func updateIndicatorPosition() {
        guard let selectedButton = buttons[safe: selectedIndex] else { return }
        self.indicatorView.frame = selectedButton.frame
    }
    
    // MARK: - Private methods
    private func clearViewIfNeeded() {
        selectedIndex = 0
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        contentStackView.removeFromSuperview()
        
        indicatorView.removeFromSuperview()
        indicatorView = makeIndicatorView()
    }
    
    // MARK: - Button
    private func addButtons() {
        for (index, segment) in segments.enumerated() {
            let button = makeButton(segment: segment, index: index)
            buttons.append(button)
            contentStackView.addArrangedSubview(button)
        }
    }
    
    private func makeButton(segment: T, index: Int) -> UIButton {
        let button = UIButton()
        let title = delegate?.segmentedControl(titleFor: segment, at: index)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .selected)
        button.addAction(
            .init(
                handler: { [weak self] _ in
                    self?.handleButtonTap(at: segment, index: index)
                }
            ),
            for: .touchUpInside
        )
        
        return button
    }
    
    private func handleButtonTap(at segment: T, index: Int) {
        setSelectedIndex(index)
        delegate?.segmentedControl(didSelectSegment: segment, at: index)
    }
    
    // MARK: - Stack view
    private func setupStackView() {
        addSubview(contentStackView)
        contentStackView.pinSuperview(
            leading: 6.0,
            trailing: -6.0,
            top: 6.0,
            bottom: -6.0
        )
    }
    
    private func makeContentStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    // MARK: - Indicator view
    private func makeIndicatorView() -> UIView {
        let indicatorView = UIView()
        indicatorView.backgroundColor = indicatorColor
        indicatorView.layer.cornerRadius = 15.0
        return indicatorView
    }
}
