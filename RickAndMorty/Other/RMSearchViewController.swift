//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.04.2023.
//

import UIKit

struct Config {
    enum `Type` {
        case character
        case episode
        case location
    }
    let type: `Type`
}

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    // MARK: - Properties
    private let config: Config
    
    // MARK: - Lifecycle
    init(config: Config) {
        self.config = config
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
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Actions
    
}
