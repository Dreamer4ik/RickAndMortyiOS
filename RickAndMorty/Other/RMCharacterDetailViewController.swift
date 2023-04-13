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
    private let detailView: RMCharacterDetailView
    
    // MARK: - Lifecycle
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        
        view.addSubview(detailView)
        detailView.addConstraintsToFillViewWithoutSafeArea(view)
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    // MARK: - Actions
    @objc private func didTapShare() {
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier,
                for: indexPath
            ) as? RMCharacterPhotoCollectionViewCell else {
                preconditionFailure("RMCharacterPhotoCollectionViewCell error")
            }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier,
                for: indexPath
            ) as? RMCharacterInfoCollectionViewCell else {
                preconditionFailure("RMCharacterPhotoCollectionViewCell error")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier,
                for: indexPath
            ) as? RMCharacterEpisodeCollectionViewCell else {
                preconditionFailure("RMCharacterPhotoCollectionViewCell error")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            
        case .photo, .information:
            break
        case .episodes:
            let episodesUrl = self.viewModel.episodes
            let selectionEpisode = episodesUrl[indexPath.row]
            let vc = RMEpisodeDetailViewController(url: URL(string: selectionEpisode))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
