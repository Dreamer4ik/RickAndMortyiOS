//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 02.05.2023.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView,
                           didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
    // MARK: - Properties
    weak var delegate: RMSearchViewDelegate?
    private let viewModel: RMSearchViewViewModel
    
    private let searchInputView = RMSearchInputView()
    private let noResultsView = RMNoSearchResultsView()
    
    // MARK: - Lifecycle
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureUI()
        viewModel.registerOptionChangeBlock { tuple  in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        viewModel.registerSearchResultHandler { results in
            print(results)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .systemBackground
        
        addSubviews(noResultsView, searchInputView)
        
        let searchHeight: CGFloat = viewModel.config.type == .episode ? 55 : 110
        searchInputView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: searchHeight)
        searchInputView.configure(viewModel: .init(type: viewModel.config.type))
        searchInputView.delegate = self
        
        noResultsView.center(inView: self)
        noResultsView.setDimensions(width: 150, height: 150)
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
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

// MARK: - RMSearchInputViewDelegate
extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView) {
        viewModel.executeSearch()
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String) {
        viewModel.set(query: text)
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}
