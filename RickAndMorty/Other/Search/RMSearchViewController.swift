//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.04.2023.
//

import UIKit

/// Configuration for search session
struct SearchConfig {
    enum `Type` {
        case character // name | status | gender
        case episode // name
        case location // name | type
        
        var endpoint: RMEndpoint {
            switch self {
            case .character:
                return .character
            case .episode:
                return .episode
            case .location:
                return .location
            }
        }
        
        var title: String {
            switch self {
            case .character:
                return "Search Characters"
            case .episode:
                return "Search Episode"
            case .location:
                return "Search Location"
            }
        }
    }
    let type: `Type`
}

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: RMSearchViewViewModel
    private let searchView: RMSearchView
    
    // MARK: - Lifecycle
    init(config: SearchConfig) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchView)
        searchView.delegate = self
        searchView.addConstraintsToFillViewWithoutSafeArea(view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapExecuteSearch))
    }
    
    // MARK: - Actions
    @objc private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }
}

// MARK: - RMSearchViewDelegate
extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectLocation location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}
