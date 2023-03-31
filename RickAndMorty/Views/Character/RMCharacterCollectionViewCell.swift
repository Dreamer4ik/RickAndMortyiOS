//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 28.02.2023.
//

import UIKit

/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - Helpers
    private func configureUI() {
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
        
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        
        statusLabel.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor, paddingLeft: 7,
                           paddingBottom: 3, paddingRight: 7, height: 30)
        
        nameLabel.anchor(left: contentView.leftAnchor, bottom: statusLabel.topAnchor,
                         right: contentView.rightAnchor, paddingLeft: 7,
                         paddingRight: 7, height: 30)
        
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nameLabel.topAnchor,
                         right: contentView.rightAnchor, paddingBottom: 3)
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
