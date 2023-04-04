//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 04.04.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Lifecycle
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
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
        title = "Episode"
        view.backgroundColor = .tertiarySystemBackground
    }
    
    // MARK: - Actions
    
}
