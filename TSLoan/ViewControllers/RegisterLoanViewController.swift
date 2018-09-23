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

class RegisterLoanViewController: UIViewController {
    
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var fullNameTextField: UITextField!
    @IBOutlet private var nationalIdNumberTextField: UITextField!
    @IBOutlet private var selectProvinceButton: UIButton!
    @IBOutlet private var selectMonthlyIncomeButton: UIButton!
    @IBOutlet private var submitButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterLoanViewModel()
    
    // MARK: - Dropdown
    private let provinceDropDown = DropDown()
    private let monthlyIncomeDropDown = DropDown()
    
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
        provinceDropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        
        provinceDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectProvinceButton.setTitle(item, for: .normal)
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
        monthlyIncomeDropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        
        monthlyIncomeDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectMonthlyIncomeButton.setTitle(item, for: .normal)
        }
        
        selectMonthlyIncomeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.monthlyIncomeDropDown.show()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        // TODO: validate fields
        // TODO: bind field to view model
        // TODO: bind submit button
    }
    
}
