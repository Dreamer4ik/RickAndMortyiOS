//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 04.04.2023.
//

import UIKit

final class RMEpisodeDetailView: UIView {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .red
    }
    
    // MARK: - Actions
    
}
