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
    
    // MARK: - Helpers
    private func configureUI() {
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchView)
        searchView.addConstraintsToFillViewWithoutSafeArea(view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapExecuteSearch))
    }
    
    // MARK: - Actions
    @objc private func didTapExecuteSearch() {
        
    }
}
