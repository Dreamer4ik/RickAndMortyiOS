//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 02.05.2023.
//

import UIKit

final class RMSearchView: UIView {
    // MARK: - Properties
    private let viewModel: RMSearchViewViewModel
    
    private let noResultsView = RMNoSearchResultsView()
    
    // MARK: - Lifecycle
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .systemBackground
        
        addSubviews(noResultsView)
        noResultsView.center(inView: self)
        noResultsView.setDimensions(width: 150, height: 150)
    }
    
    // MARK: - Actions
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
