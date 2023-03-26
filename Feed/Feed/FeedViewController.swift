//
//  FruitsViewController.swift
//  CustomCollectionLayout
//
//  Created by Maksym Husar on 2/13/19.
//  Copyright © 2019 MaksymHusar. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController {

    var presenter: FeedPresenter!

    private enum PresentationStyle: String, CaseIterable {
        case table
        case defaultGrid
        case customGrid

        var buttonImage: UIImage {
            switch self {
            case .table: return UIImage(named: "table")!
            case .defaultGrid: return UIImage(named: "default_grid")!
            case .customGrid: return UIImage(named: "custom_grid")!
            }
        }
    }

    private var selectedStyle: PresentationStyle = .table {
        didSet { updatePresentationStyle() }
    }

    private var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
            let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
                .table: TabledContentCollectionViewDelegate(),
                .defaultGrid: DefaultGriddedContentCollectionViewDelegate(),
                .customGrid: CustomGriddedContentCollectionViewDelegate(),
            ]
            result.values.forEach {
                $0.didSelectItem = { _ in
                    print("Item selected")
                }
            }
            return result
        }()

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter!.getProducts()

        self.collectionView.register(FeedCollectionViewCell.self,
                                      forCellWithReuseIdentifier: FeedCollectionViewCell.reuseID)
        collectionView.contentInset = .zero
        updatePresentationStyle()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Catalog"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
    }

    private func updatePresentationStyle() {
        collectionView.delegate = styleDelegates[selectedStyle]
        collectionView.performBatchUpdates({
            collectionView.reloadData()
        }, completion: nil)

        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
    }

    @objc private func changeContentLayout() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]

    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.products.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseID,
                                                            for: indexPath) as? FeedCollectionViewCell else {
            fatalError("Wrong cell")
        }
        let product = presenter?.products[indexPath.item]
        cell.update(title: product!.name, imageURL: product!.description)
        return cell
    }
    
}
