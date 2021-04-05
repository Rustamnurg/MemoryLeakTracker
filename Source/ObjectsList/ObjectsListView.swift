//
//  ObjectsListView.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 03.04.2021.
//

import UIKit

final class ObjectsListView: UIView {
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 20,
            left: 10,
            bottom: 10,
            right: 10
        )
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .purple
        return button
    }()
    
    // MARK: - Init

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(collectionView)
        addSubview(resetButton)
    }
    
    private func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .zero).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero).isActive = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16 - safeAreaInsets.bottom).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
