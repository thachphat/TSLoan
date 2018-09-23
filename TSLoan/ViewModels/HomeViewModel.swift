//
//  HomeViewModel.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

class HomeViewModel {

    let minimumLoanAmount: Driver<String>
    let maximumLoanAmount: Driver<String>
    let minimumTenor: Driver<String>
    let maximumTenor: Driver<String>
    let interestRate: Driver<String>
    let bankLogoURL: Driver<URL?>
    let bankName: Driver<String>
    
    init(provider: MoyaProvider<APIService>) {
        let request = provider.rx.request(.offer)
        let offer = request
            .mapObject(Offer.self)
        minimumLoanAmount = offer.map({ "\($0.minimumLoanAmount ?? 0.0)" }).asDriver(onErrorJustReturn: "")
        maximumLoanAmount = offer.map({ "\($0.maximumLoanAmount ?? 0.0)" }).asDriver(onErrorJustReturn: "")
        minimumTenor = offer.map({ "\($0.minimumTenor ?? 0)" }).asDriver(onErrorJustReturn: "")
        maximumTenor = offer.map({ "\($0.maximumTenor ?? 0)" }).asDriver(onErrorJustReturn: "")
        interestRate = offer.map({ "\($0.interestRate ?? 0.0)" }).asDriver(onErrorJustReturn: "")
        bankLogoURL = offer.map({ $0.bank.logo }).asDriver(onErrorJustReturn: nil)
        bankName = offer.map({ $0.bank.name }).asDriver(onErrorJustReturn: "")
        
    }
    
}
