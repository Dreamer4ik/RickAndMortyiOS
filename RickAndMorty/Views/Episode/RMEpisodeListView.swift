//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 05.04.2023.
//

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject {
    func rmEpisodeListView(
        _ characterListView: RMEpisodeListView,
        didSelectEpisode episode: RMEpisode
    )
}
/// View that handles showing list of episodes, loader, etc.
final class RMEpisodeListView: UIView {
    // MARK: - Properties
    public weak var delegate: RMEpisodeListViewDelegate?
    private let viewModel = RMEpisodeListViewViewModel()
    
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
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        viewModel.fetchEpisodes()
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

// MARK: - RMEpisodeListViewViewModelDelegate
extension RMEpisodeListView: RMEpisodeListViewViewModelDelegate {
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
    
    func didLoadInitialEpisodes() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
            self.collectionView.alpha = 1
        }
        animator.startAnimation()
    }
}
