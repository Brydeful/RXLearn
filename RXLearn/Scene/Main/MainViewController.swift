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
    
    private let viewModel: ViewModel
    
    private var disposeBag = DisposeBag()
    
    private lazy var validateTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    private lazy var disableSwitch: UISwitch = {
        let disableSwitch = UISwitch()
        return disableSwitch
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
        view.addSubview(disableSwitch)
    }
    
    func constraintSubviews() {
        validateTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        disableSwitch.snp.makeConstraints {
            $0.top.equalTo(validateTextField.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
        }
    }

    func setupBinding(viewModel: MainViewModelProtocol) {
        validateTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.validateText)
            .disposed(by: disposeBag)
        disableSwitch.rx.isOn.changed
            .bind(to: viewModel.input.isEnableLogicSwitchState)
            .disposed(by: disposeBag)
        viewModel.output.viewState.drive(onNext: { [weak self] value in
            self?.changeState(value)
        }).disposed(by: disposeBag)
    }
    
    func changeState(_ state: MainControllerState) {
        switch state {
        case .normal:
            view.backgroundColor = .blue
        case .error:
            view.backgroundColor = .red
        }
    }

}
