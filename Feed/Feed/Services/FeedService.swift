//
//  FeedService.swift
//  Feed
//
//  Created by Максим Тарасов on 26.03.2023.
//

import Foundation
import Combine

protocol FeedService {
    func getProducts() throws -> [Product]
}
