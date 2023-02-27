//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 13.02.2023.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    // MARK: - Properties
    private let characterListView = CharacterListView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .purple
        title = "Characters"
        
        view.addSubview(characterListView)
        characterListView.addConstraintsToFillViewWithoutSafeArea(view)
    }
    
}
