//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 27.02.2023.
//

import UIKit

/// View that handles showing list of characters, loader, etc.
final class CharacterListView: UIView {
    // MARK: - Properties
    private let viewModel = CharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
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
        backgroundColor = .systemBlue
        addSubviews(collectionView, spinner)
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
        spinner.startAnimating()
        
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.addConstraintsToFillView(self)
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.stopAnimating()
            
            self.collectionView.isHidden = false
            let animator = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
                self.collectionView.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
