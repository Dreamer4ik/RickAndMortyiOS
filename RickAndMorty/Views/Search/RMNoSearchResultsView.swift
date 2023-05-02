//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 02.05.2023.
//

import UIKit

class RMNoSearchResultsView: UIView {
    // MARK: - Properties
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        addSubviews(iconView, label)
        
        iconView.center(inView: self)
        iconView.setDimensions(width: 90, height: 90)
        
        label.anchor(top: iconView.bottomAnchor, paddingTop: 10)
        label.centerX(inView: iconView)
        
        configure()
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
