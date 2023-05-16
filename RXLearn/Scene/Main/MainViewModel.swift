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

    var validateText: PublishSubject<String> { get set }
    
    func start()
    
}

final class MainViewModel: MainViewModelProtocol {
    
    typealias Controller = MainViewControllerProtocol
    
    // MARK: Properties
    
    var validateText: PublishSubject<String> = .init()
    
    private var disposeBag = DisposeBag()
    
    weak var controller: Controller?
    
    func start() {
        validateText.subscribe(onNext: { [weak self] value in
            guard let self else { return }
            let state: MainControllerState = value.count.isMultiple(of: 2) ? .normal : .error
            self.controller?.changeState(state)
        }, onError: { [weak self] _ in self?.controller?.changeState(.error) })
        .disposed(by: disposeBag)
    }
    
}
