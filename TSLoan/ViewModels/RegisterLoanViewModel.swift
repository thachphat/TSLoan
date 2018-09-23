//
//  RegisterLoanViewModel.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import Result

class RegisterLoanViewModel {
    
    let validatedPhoneNumber: Driver<Bool>
    let validatedFullName: Driver<Bool>
    let validatedNationalIDNumber: Driver<Bool>
    let provinces: Driver<[String]>
    let registered: Driver<Result<Loan, AnyError>>
    
    init(
        input: (
        phoneNumber: Driver<String>,
        fullName: Driver<String>,
        nationalIDNumber: Driver<String>,
        province: Driver<String>,
        monthlyIncome: Driver<Int>,
        submitTaps: Signal<()>
        ),
        dependency: (
        provider: MoyaProvider<APIService>,
        validationService: ValidationService
        )
        ) {
        let validationService = dependency.validationService
        
        validatedPhoneNumber = input.phoneNumber.map({ validationService.validatePhoneNumber($0) })
        validatedFullName = input.phoneNumber.map({ validationService.validateName($0) })
        validatedNationalIDNumber = input.phoneNumber.map({ validationService.validateNationalIDNumber($0) })
        
        let provider = dependency.provider
        let provinceList = provider.rx.request(.provinces).mapObject(ProvinceList.self)
        provinces = provinceList.map({ $0.provinces }).asDriver(onErrorJustReturn: [])
        
        let loan = Observable.combineLatest(input.phoneNumber.asObservable(), input.fullName.asObservable(), input.nationalIDNumber.asObservable(), input.province.asObservable(), input.monthlyIncome.asObservable()) { phoneNumber, fullName, nationalIdNumber, province, monthlyIncome -> Loan in
            var loan = Loan(JSON: [:])!
            loan.phoneNumber = phoneNumber
            loan.fullName = fullName
            loan.nationalIdNumber = nationalIdNumber
            loan.province = province
            loan.monthlyIncome = monthlyIncome
            return loan
            }.asDriver(onErrorJustReturn: Loan(JSON: [:])!)
        registered = input.submitTaps.withLatestFrom(loan)
            .flatMapLatest({ provider.rx.request(.loans($0))
                .mapObject(Loan.self)
                .map({ Result<Loan, AnyError>.success($0) })
                .asDriver(onErrorJustReturn: Result.failure(AnyError(MoyaError.requestMapping(""))))
            })
    }
    
}
