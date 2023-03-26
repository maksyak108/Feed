//
//  FeedPresenter.swift
//  Feed
//
//  Created by Максим Тарасов on 26.03.2023.
//

import UIKit

class FeedPresenter {
    
    weak var view: FeedViewController?
    var products: [Product] = []
        
    private let feedService = MockFeedService.shared
    
    func getProducts() {
        do{
            products = try feedService.getProducts()
        }catch{
            print(error)
        }
    }
    
    // MARK: - Открытие экрана товара
    func didTapOnSection(productId: Int){
        print("PRESENTER \(productId)")
    }
    
}
