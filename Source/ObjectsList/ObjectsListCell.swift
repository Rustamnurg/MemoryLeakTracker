//
//  ObjectsListCell.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 03.04.2021.
//

import UIKit

final class ObjectsListCell: UICollectionViewCell {
    // MARK: - Properties
    
    struct ViewModel {
        let message: String
    }

    private enum Appearance {
        static let titleLabelHorizontalSpace: CGFloat = 16
        static let titleLabelVerticalSpace: CGFloat = 8
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private methods
    
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    private func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Appearance.titleLabelVerticalSpace).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Appearance.titleLabelHorizontalSpace).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Appearance.titleLabelVerticalSpace).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Appearance.titleLabelHorizontalSpace).isActive = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        titleLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}

extension ObjectsListCell {
    // MARK: - Configure
    
    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.message
    }
    
}

extension ObjectsListCell {
    // MARK: - Constants
    
    struct Constants {
        static let cellIdentifier = "ObjectsListCell"
    }
    
}
