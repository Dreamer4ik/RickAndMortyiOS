//
//  RMLocationDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 02.05.2023.
//

import UIKit

protocol RMLocationDetailViewDelegate: AnyObject {
    func RMLocationDetailView(
        _ detailView: RMLocationDetailView,
        didSelect character: RMCharacter
    )
}

final class RMLocationDetailView: UIView {
    // MARK: - Properties
    public weak var delegate: RMLocationDetailViewDelegate?
    
    private var viewModel: RMLocationDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
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
        backgroundColor = .systemBackground
        
        configureCollectionView()
        addSubviews(spinner)
        
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
        
        spinner.startAnimating()
    }
    
    private func configureCollectionView() {
        self.collectionView = createCollectionView()
        guard let collectionView = self.collectionView else {
            return
        }
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RMEpisodeInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier)
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        return collectionView
    }
    
    public func configure(with viewModel: RMLocationDetailViewViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Actions
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RMLocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        
        let sectionType = sections[section]
        switch sectionType {
        case .information(viewModels: let viewModels):
            return viewModels.count
        case .characters(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModels else {
            preconditionFailure("RMLocationDetailView cellForItemAt cellViewModels error")
        }
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier,
                for: indexPath
            ) as? RMEpisodeInfoCollectionViewCell else {
                preconditionFailure("RMLocationInfoCollectionViewCell error")
            }
            cell.configure(viewModel: cellViewModel)
            return cell
        case .characters(viewModels: let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                for: indexPath
            ) as? RMCharacterCollectionViewCell else {
                preconditionFailure("RMLocationInfoCollectionViewCell error")
            }
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else {
            preconditionFailure("RMLocationDetailView no viewModel")
        }
        
        let sections = viewModel.cellViewModels
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information:
            break
        case .characters:
            guard let character = viewModel.character(at: indexPath.row) else {
                return
            }
            delegate?.RMLocationDetailView(self, didSelect: character)
        }
    }
}

extension RMLocationDetailView {
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout()
        }
        
        switch sections[section] {
        case .information(viewModels: let viewModels):
            return createInfoLayout()
        case .characters(viewModels: let viewModels):
            return createCharacterLayout()
        }
    }
    
    private func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(80)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(UIDevice.isiPhone ? 0.5 : 0.25),
                heightDimension: .fractionalHeight(1.0))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(UIDevice.isiPhone ? 260 : 320)),
            subitems: UIDevice.isiPhone ? [item, item] : [item, item, item, item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
