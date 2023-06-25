//
//  MainViewModel.swift
//  RXLearn
//
//  Created by Вячеслав Грудкин on 15.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelProtocol {

    var input: MainViewModel.Input { get set }
    var output: MainViewModel.Output { get set }
    
}

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: Properties
    
    var input = Input()
    var output: Output
    
    // MARK: Initializers
    
    init() {
        let viewState = Observable.combineLatest(input.isEnableLogicSwitchState.asObservable(), input.validateText) { isEnabled, text in
            (isEnabled && text.count.isMultiple(of: 2)) ? MainControllerState.normal : MainControllerState.error
        }.asDriver(onErrorJustReturn: .error)
        output = Output(viewState: viewState)
    }
    
    struct Input {
        let validateText = PublishRelay<String>()
        let isEnableLogicSwitchState = PublishRelay<Bool>()
    }
    
    struct Output {
        var viewState: Driver<MainControllerState>
    }
    
}
