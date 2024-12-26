//
//  TrendsScreenViewController.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import UIKit
import Combine

final class TrendsScreenViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var collectionContainerView: UIView!
    @IBOutlet private weak var segmentedControlContainerView: UIView!
    
    private lazy var segmentedControl = makeSegmentedControl()
    private lazy var sectionsCollectionView = makeSectionsCollectionView()
    
    private let viewModel: TrendsScreenViewModelProtocol
    private var binding: Set<AnyCancellable> = []
    
    // MARK: - Init
    init(viewModel: TrendsScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        configureUI()
        bind()
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    // MARK: - State machine
    private func bind() {
        viewModel
            .eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &binding)
    }
    
    private func handleEvent(_ event: TrendsScreenViewModel.Event) {
        switch event {
        case .reloadUI:
            updateUI()
        case .displaySection(let index):
            displaySection(index: index)
        }
    }
    
    // MARK: - Configure
    private func setDelegates() {
        customNavigationController?.navigationDelegate = self
        segmentedControl.delegate = self
        sectionsCollectionView.delegate = self
        sectionsCollectionView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = Asset.Colors.backgroundBlack.color
        customNavigationController?.setNavigationBarTitle(Constants.navigationTitle)
        
        collectionContainerView.backgroundColor = .clear
        collectionContainerView.addSubview(sectionsCollectionView)
        sectionsCollectionView.pinSuperview()
        
        segmentedControlContainerView.backgroundColor = .clear
        segmentedControlContainerView.addSubview(segmentedControl)
        segmentedControl.pinSuperview()
    }
    
    // MARK: - Private methods
    private func updateUI() {
        sectionsCollectionView.reloadData()
        segmentedControl.segments = viewModel.getScoreTypes()
        segmentedControl.layoutIfNeeded()
    }
    
    private func displaySection(index: Int) {
        segmentedControl.setSelectedIndex(index)
        sectionsCollectionView.scrollToItem(
            at: .init(item: index, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    // MARK: - Segmented control
    private func makeSegmentedControl() -> CustomSegmentedControl<ScoreSectionModel.ScoreType> {
        let segmentedControl = CustomSegmentedControl<ScoreSectionModel.ScoreType>()
        segmentedControl.backgroundColor = Asset.Colors.grayDark.color
        segmentedControl.layer.cornerRadius = 15.0
        return segmentedControl
    }
    
    // MARK: - Collection view
    private func makeSectionsCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let nibName = String(describing: ScoreSectionCollectionViewCell.self)
        let sectionCellNib = UINib(nibName: nibName, bundle: nil)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.register(sectionCellNib, forCellWithReuseIdentifier: ScoreSectionCollectionViewCell.cellIdentifier)
        
        return collectionView
    }
}

// MARK: - SegmentedControlDelegate
extension TrendsScreenViewController: CustomSegmentedControlDelegate {
    func segmentedControl<T>(didSelectSegment segment: T, at index: Int) {
        guard let segment = segment as? ScoreSectionModel.ScoreType else { return }
        viewModel.didSelect(section: segment)
    }
    
    func segmentedControl<T>(titleFor segment: T, at index: Int) -> String {
        guard let segment = segment as? ScoreSectionModel.ScoreType else { return "" }
        return segment.title
    }
}

// MARK: - UICollectionViewDelegate
extension TrendsScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ScoreSectionCollectionViewCell.cellIdentifier,
            for: indexPath) as? ScoreSectionCollectionViewCell
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        guard let cellViewModel = viewModel.getScoreSectionViewModel(at: indexPath.row)
        else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        cell.update(using: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let section = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        viewModel.didScroll(to: section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = (scrollView.contentOffset.x / scrollView.bounds.width)
        segmentedControl.animateIndicatorPosition(position)
    }
}

// MARK: - NavigationControllerDelegate
extension TrendsScreenViewController: CustomNavigationControllerDelegate {
    func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

// MARK: - Constants
extension TrendsScreenViewController {
    private struct Constants {
        static let navigationTitle = "Trends"
    }
}
