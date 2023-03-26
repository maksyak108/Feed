//
//  SceneDelegate.swift
//  Feed
//
//  Created by Максим Тарасов on 25.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let feedVC = FeedViewController()
        let presenter = FeedPresenter()
        feedVC.presenter = presenter
        presenter.view = feedVC
        let navigationController = UINavigationController(rootViewController: feedVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

