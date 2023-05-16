//
//  MainViewController.swift
//  RXLearn
//
//  Created by Вячеслав Грудкин on 15.05.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol MainViewControllerProtocol: AnyObject {
    
    func changeState(_ state: MainControllerState)
    
}

final class MainViewController: UIViewController {
    
    typealias ViewModel = MainViewModelProtocol
    
    // MARK: Properties
    
    var viewModel: ViewModel?
    
    private var disposeBag = DisposeBag()
    
    private lazy var validateTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        viewModel?.start()
    }
    
}

// MARK: - Setup

private extension MainViewController {
    
    func commonInit() {
        addSubviews()
        constraintSubviews()
        setupBinding()
        view.backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        view.addSubview(validateTextField)
    }
    
    func constraintSubviews() {
        validateTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func setupBinding() {
        guard let viewModel else { return }
        validateTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.validateText)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    
    func changeState(_ state: MainControllerState) {
        switch state {
        case .normal:
            view.backgroundColor = .systemBackground
        case .error:
            view.backgroundColor = .red
        }
    }
    
}
