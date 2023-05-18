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

final class MainViewController: UIViewController {
    
    typealias ViewModel = MainViewModelProtocol
    
    // MARK: Properties
    
    private var viewModel: ViewModel
    
    private var disposeBag = DisposeBag()
    
    private lazy var validateTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    // MARK: Initializers
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
}

// MARK: - Setup

private extension MainViewController {
    
    func commonInit() {
        addSubviews()
        constraintSubviews()
        setupBinding(viewModel: viewModel)
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

    func setupBinding(viewModel: MainViewModelProtocol) {
        validateTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.validateText)
            .disposed(by: disposeBag)
        viewModel.output.viewState.drive(onNext: { [weak self] value in
            self?.changeState(value)
        }).disposed(by: disposeBag)
    }
    
    func changeState(_ state: MainControllerState) {
        switch state {
        case .normal:
            view.backgroundColor = .systemBackground
        case .error:
            view.backgroundColor = .red
        }
    }

}
