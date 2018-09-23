//
//  HomeViewController.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import UIKit
import Moya_ObjectMapper
import Moya
import RxSwift
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet private var minimumLoanAmountLabel: UILabel!
    @IBOutlet private var maximumLoanAmountLabel: UILabel!
    @IBOutlet private var minimumTenorLabel: UILabel!
    @IBOutlet private var maximumTenorLabel: UILabel!
    @IBOutlet private var interestRateLabel: UILabel!
    @IBOutlet private var bankLogoImageView: UIImageView!
    @IBOutlet private var bankNameLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel(provider: apiServiceProvider)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.minimumLoanAmount.drive(minimumLoanAmountLabel.rx.text).disposed(by: disposeBag)
        viewModel.maximumLoanAmount.drive(maximumLoanAmountLabel.rx.text).disposed(by: disposeBag)
        viewModel.minimumTenor.drive(minimumTenorLabel.rx.text).disposed(by: disposeBag)
        viewModel.maximumTenor.drive(maximumTenorLabel.rx.text).disposed(by: disposeBag)
        viewModel.interestRate.drive(interestRateLabel.rx.text).disposed(by: disposeBag)
        viewModel.bankLogoURL.drive(onNext: { [weak self] (url) in
            self?.bankLogoImageView.sd_setImage(with: url, completed: nil)
        }).disposed(by: disposeBag)
        viewModel.bankName.drive(bankNameLabel.rx.text).disposed(by: disposeBag)
    }
    
}

