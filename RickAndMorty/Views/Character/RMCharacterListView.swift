//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 27.02.2023.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(
        _ characterListView: RMCharacterListView,
        didSelectCharacter character: RMCharacter
    )
}
/// View that handles showing list of characters, loader, etc.
final class RMCharacterListView: UIView {
    // MARK: - Properties
    public weak var delegate: RMCharacterListViewDelegate?
    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        viewModel.fetchCharacters()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(collectionView, spinner)
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
        spinner.startAnimating()
        
        setUpCollectionView()
        viewModel.delegate = self
    }
    
    private func setUpCollectionView() {
        collectionView.addConstraintsToFillView(self)
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - RMCharacterListViewViewModelDelegate
extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
            self.collectionView.alpha = 1
        }
        animator.startAnimation()
    }
}
