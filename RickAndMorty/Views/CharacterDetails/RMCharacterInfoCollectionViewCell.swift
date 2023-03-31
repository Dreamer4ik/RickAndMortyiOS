//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ivan Potapenko on 29.03.2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
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
        titleLabel.text = nil
        valueLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
    }
    
    // MARK: - Helpers
    private func configureUI() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius =  8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
        titleContainerView.addSubview(titleLabel)
        
        titleContainerView.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor, height: contentView.height * 0.33)
        
        titleLabel.addConstraintsToFillView(titleContainerView)
        
        iconImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 35, paddingLeft: 20)
        iconImageView.setDimensions(width: 30, height: 30)
    
        
        valueLabel.centerY(inView: iconImageView)
        valueLabel.anchor(left: iconImageView.rightAnchor, bottom: titleContainerView.topAnchor,
                          right: contentView.rightAnchor, paddingLeft: 10, paddingRight: 10)
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}
