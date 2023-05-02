//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.02.2023.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {
    // MARK: - Properties
    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Locations"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        
        primaryView.delegate = self
        view.addSubview(primaryView)
        primaryView.addConstraintsToFillViewWithoutSafeArea(view)
    }
    
    // MARK: - Actions
    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - RMLocationViewViewModelDelegate
extension RMLocationViewController: RMLocationViewViewModelDelegate {
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}

// MARK: - RMLocationViewDelegate
extension RMLocationViewController: RMLocationViewDelegate {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
