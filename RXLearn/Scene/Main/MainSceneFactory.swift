//
//  MainSceneFactory.swift
//  RXLearn
//
//  Created by Вячеслав Грудкин on 15.05.2023.
//

import UIKit

final class MainSceneFactory {
    
    static func buildModule() -> UIViewController {
        let viewModel = MainViewModel()
        let controller = MainViewController()
        controller.viewModel = viewModel
        viewModel.controller = controller
        return controller
    }
    
}
