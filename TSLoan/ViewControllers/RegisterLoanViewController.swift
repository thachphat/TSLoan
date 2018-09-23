//
//  RegisterLoanViewController.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa

class RegisterLoanViewController: UIViewController {
    
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var fullNameTextField: UITextField!
    @IBOutlet private var nationalIdNumberTextField: UITextField!
    @IBOutlet private var selectProvinceButton: UIButton!
    @IBOutlet private var selectMonthlyIncomeButton: UIButton!
    @IBOutlet private var submitButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Dropdown
    private let provinceDropDown = DropDown()
    private let provinceSubject = PublishSubject<String>()
    private let monthlyIncomeDropDown = DropDown()
    private let monthlyIncomeSubject = PublishSubject<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDropDowns()
        bindViewModel()
    }
    
    private func setUpDropDowns() {
        DropDown.setupDefaultAppearance()
        setUpProvinceDropDown()
        setUpMonthlyIncomeDropDown()
    }
    
    private func setUpProvinceDropDown() {
        provinceDropDown.anchorView = selectProvinceButton
        provinceDropDown.bottomOffset = CGPoint(x: 0, y: selectProvinceButton.bounds.height)
        
        provinceDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectProvinceButton.setTitle(item, for: .normal)
            self?.provinceSubject.on(.next(item))
        }
        
        selectProvinceButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.provinceDropDown.show()
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpMonthlyIncomeDropDown() {
        monthlyIncomeDropDown.anchorView = selectMonthlyIncomeButton
        monthlyIncomeDropDown.bottomOffset = CGPoint(x: 0, y: selectMonthlyIncomeButton.bounds.height)
        monthlyIncomeDropDown.dataSource = MonthlyIncome.allTypeOfIncomes().map({ $0.description() })
        
        monthlyIncomeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectMonthlyIncomeButton.setTitle(item, for: .normal)
            self?.monthlyIncomeSubject.on(.next(MonthlyIncome.allTypeOfIncomes()[index].rawValue))
        }
        
        selectMonthlyIncomeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.monthlyIncomeDropDown.show()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let viewModel = RegisterLoanViewModel(
            input: (
                phoneNumber: phoneNumberTextField.rx.text.orEmpty.asDriver(),
                fullName: fullNameTextField.rx.text.orEmpty.asDriver(),
                nationalIDNumber: nationalIdNumberTextField.rx.text.orEmpty.asDriver(),
                province: provinceSubject.asDriver(onErrorJustReturn: ""),
                monthlyIncome: monthlyIncomeSubject.asDriver(onErrorJustReturn: 1),
                submitTaps: submitButton.rx.tap.asSignal()
            ),
            dependency: (
                provider: apiServiceProvider,
                validationService: TSLoanValidationService()
            )
        )
        
        viewModel.validatedPhoneNumber.drive(onNext: { [weak self] (isValidated) in
            self?.phoneNumberTextField.layer.borderColor = isValidated ? UIColor.green.cgColor : UIColor.red.cgColor
            self?.phoneNumberTextField.layer.borderWidth = 1
        }).disposed(by: disposeBag)
        
        viewModel.validatedFullName.drive(onNext: { [weak self] (isValidated) in
            self?.fullNameTextField.layer.borderColor = isValidated ? UIColor.green.cgColor : UIColor.red.cgColor
            self?.fullNameTextField.layer.borderWidth = 1
        }).disposed(by: disposeBag)
        
        viewModel.validatedNationalIDNumber.drive(onNext: { [weak self] (isValidated) in
            self?.nationalIdNumberTextField.layer.borderColor = isValidated ? UIColor.green.cgColor : UIColor.red.cgColor
            self?.nationalIdNumberTextField.layer.borderWidth = 1
        }).disposed(by: disposeBag)
        
        viewModel.provinces.drive(onNext: { [weak self] (provinces) in
            self?.provinceDropDown.dataSource = provinces
        }).disposed(by: disposeBag)
        
        viewModel.registered.drive(onNext: { [weak self] (result) in
            switch result {
            case .success(let loan):
                AlertUtils.showPromptMessage(loan.toJSONString() ?? "cannot register loan", from: self)
            case .failure(let error):
                AlertUtils.showPromptMessage(error.localizedDescription, from: self)
            }
        }).disposed(by: disposeBag)
    }
    
}
