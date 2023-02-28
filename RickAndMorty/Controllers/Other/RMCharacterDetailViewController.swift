//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 28.02.2023.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: RMCharacterDetailViewViewModel
    // MARK: - Lifecycle
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
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
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
}
