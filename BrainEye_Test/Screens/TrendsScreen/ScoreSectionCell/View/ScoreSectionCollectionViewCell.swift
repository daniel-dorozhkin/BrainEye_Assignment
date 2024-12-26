//
//  ScoreSectionCollectionViewCell.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 22/12/2024.
//

import UIKit

class ScoreSectionCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "ScoreSectionCollectionViewCell"
    
    // MARK: - Properties
    @IBOutlet private weak var graphHeaderLabel: UILabel!
    @IBOutlet private weak var graphDateRangeLabel: UILabel!
    @IBOutlet private weak var graphContainerView: UIView!
    
    @IBOutlet private weak var insightsHeaderLabel: UILabel!
    @IBOutlet private weak var insightsContainerView: UIView!
    
    private let insightsView = ScoreInsightsView()
    private var viewModel: ScoreSectionCellViewModelProtocol?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        clearBackgroundColor()
        configureUI()
    }
    
    // MARK: - Public methods
    func update(using viewModel: ScoreSectionCellViewModelProtocol) {
        self.viewModel = viewModel
        updateLabels()
        addGraphView()
    }
    
    // MARK: - Configure
    private func configureUI() {
        graphHeaderLabel.textColor = Asset.Colors.textWhite.color.withAlphaComponent(0.87)
        graphHeaderLabel.font = FontConstants.body2
        
        graphDateRangeLabel.textColor = Asset.Colors.textWhite.color.withAlphaComponent(0.75)
        graphDateRangeLabel.font = FontConstants.body3
        
        insightsHeaderLabel.textColor = Asset.Colors.textWhite.color
        insightsHeaderLabel.font = FontConstants.heading6
        insightsHeaderLabel.text = Constants.insightsSectionHeader
        
        insightsContainerView.addSubview(insightsView)
        insightsView.pinSuperview()
    }
    
    // MARK: - Private methdos
    private func updateLabels() {
        guard let viewModel else { return }
        
        graphHeaderLabel.text = viewModel.graphHeaderTitle
        graphDateRangeLabel.text = viewModel.graphDateRangeTitle
        
        insightsView.averageScoreLabel.text = viewModel.averageScoreTitle
        insightsView.latestScoreLabel.text = viewModel.latestScoreTitle
        insightsView.rangeScoreLabel.text = viewModel.rangeScoreTitle
    }
    
    private func addGraphView() {
        guard let viewModel else { return }
        let graphView = GraphView(viewModel: viewModel.graphViewModel)
        graphContainerView.addSwiftUI(view: graphView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        graphContainerView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func clearBackgroundColor() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        graphContainerView.backgroundColor = .clear
        insightsContainerView.backgroundColor = .clear
    }
}

// MARK: - Constants
private extension ScoreSectionCollectionViewCell {
    struct Constants {
        static let insightsSectionHeader = "Insights"
    }
}
