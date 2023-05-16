//
//  AppCoordinator.swift
//  RXLearn
//
//  Created by Вячеслав Грудкин on 15.05.2023.
//

import UIKit

final class AppCoordinator {
    
    func makeRootViewController() -> UIViewController {
        let mainViewController = MainSceneFactory.buildModule()
        return mainViewController
    }
    
}
