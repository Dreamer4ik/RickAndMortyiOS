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
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .yellow
        } else if indexPath.section == 2 {
            cell.backgroundColor = .green
        }
        
        return cell
    }
}
