//
//  SceneDelegate.swift
//  RXLearn
//
//  Created by Вячеслав Грудкин on 15.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var appCoordinator = AppCoordinator()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = appCoordinator.makeRootViewController()
        window?.makeKeyAndVisible()
    }


}

