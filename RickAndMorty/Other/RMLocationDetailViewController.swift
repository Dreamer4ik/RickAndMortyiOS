//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 28.04.2023.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: RMLocationDetailViewViewModel
    private let detailView = RickAndMorty.RMLocationDetailView()
    
    // MARK: - Lifecycle
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        title = "Location"
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailView)
        detailView.delegate = self
        detailView.addConstraintsToFillViewWithoutSafeArea(view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        configureFetchData()
    }
    
    private func configureFetchData() {
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    // MARK: - Actions
    @objc private func didTapShare() {
        
    }
    
}

// MARK: - RMEpisodeDetailViewViewModelDelegate
extension RMLocationDetailViewController: RMLocationDetailViewViewModelDelegate {
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

// MARK: - RMEpisodeDetailViewDelegate
extension RMLocationDetailViewController: RMLocationDetailViewDelegate {
    func RMLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
