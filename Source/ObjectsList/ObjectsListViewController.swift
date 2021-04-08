//
//  ObjectsListViewController.swift
//  MemoryLeakTracker
//
//  Created by Rustam Nurgaliev on 03.04.2021.
//

import Foundation

final class ObjectsListViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var contentView = ObjectsListView()
    private var viewModels: [ObjectsListCell.ViewModel] = []
    
    // MARK: - Live cycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupCollectionView()
        reloadData()
    }
    
    private func setupCollectionView() {
        contentView.collectionView.register(
            ObjectsListCell.self,
            forCellWithReuseIdentifier: ObjectsListCell.Constants.cellIdentifier
        )
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    // MARK: - Action Handlers
    
    private func addTargets() {
        contentView.resetButton.addTarget(
            self,
            action: #selector(resetTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func resetTapped() {
        MemoryLeakTracker.shared.reset()
        reloadData()
    }
    
    private func reloadData() {
        viewModels = MemoryLeakTracker.shared.fetchAllActiveObjects()
            .sorted {$0.value > $1.value}
            .map { ObjectsListCell.ViewModel(message: "\($0.key) \($0.value)") }
        contentView.collectionView.reloadData()
    }
}

extension ObjectsListViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ObjectsListCell.Constants.cellIdentifier, for: indexPath) as! ObjectsListCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}


extension ObjectsListViewController: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ObjectsListViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 50)
    }
}
