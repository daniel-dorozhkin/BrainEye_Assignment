//
//  TrendsScreenViewModel.swift
//  BrainEye_Test
//
//  Created by Daniel Dorozhkin on 20/12/2024.
//

import Foundation
import Combine

protocol TrendsScreenViewModelProtocol {
    var eventPublisher: PassthroughSubject<TrendsScreenViewModel.Event, Never> { get }
    
    func viewDidLoad()
    func backButtonTapped()
    func didScroll(to section: Int)
    func didSelect(section: ScoreSectionModel.ScoreType)
    
    func getNumberOfSections() -> Int
    func getScoreSectionViewModel(at index: Int) -> ScoreSectionCellViewModelProtocol?
    func getScoreTypes() -> [ScoreSectionModel.ScoreType]
}

final class TrendsScreenViewModel: TrendsScreenViewModelProtocol {
    enum Event {
        case reloadUI
        case displaySection(index: Int)
    }
    
    // MARK: - Properties
    let eventPublisher: PassthroughSubject<Event, Never>
    
    private let coordinator: AppCoordinatorProtocol
    private let repository: TrendsRepositoryProtocol
    private var sectionModels: [ScoreSectionModel]
    
    // MARK: - Init
    init(coordinator: AppCoordinatorProtocol, repository: TrendsRepositoryProtocol) {
        self.coordinator = coordinator
        self.repository = repository
        self.sectionModels = []
        self.eventPublisher = .init()
    }
    
    // MARK: - Public methods
    func viewDidLoad() {
        updateSectionModels()
        eventPublisher.send(.reloadUI)
    }
    
    func getScoreSectionViewModel(at index: Int) -> ScoreSectionCellViewModelProtocol? {
        guard let model = sectionModels[safe: index] else { return nil }
        return ScoreSectionCellViewModel(model: model)
    }
    
    func getNumberOfSections() -> Int {
        return sectionModels.count
    }
    
    func getScoreTypes() -> [ScoreSectionModel.ScoreType] {
        return sectionModels.map { $0.scoreType }
    }
    
    // MARK: - User actions
    func backButtonTapped() {
        coordinator.closeApp()
    }
    
    func didSelect(section: ScoreSectionModel.ScoreType) {
        guard let index = sectionModels.firstIndex(where: { $0.scoreType == section })
        else { return }
        
        eventPublisher.send(.displaySection(index: index))
    }
    
    func didScroll(to section: Int) {
        guard section < sectionModels.count else { return }
        eventPublisher.send(.displaySection(index: section))
    }
    
    // MARK: - Private methods
    private func updateSectionModels() {
        let result = repository.fetchScoreSections()
        switch result {
        case .success(let sections):
            sectionModels = sections
        case .failure(let error):
            print("Failed to fetch data with: \(error)")
            break
        }
    }
}
