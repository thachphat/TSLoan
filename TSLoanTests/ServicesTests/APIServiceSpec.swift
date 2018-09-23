//
//  APIServiceSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import TSLoan

class APIServiceSpec: QuickSpec {
    
    override func spec() {
        describe("API Service") {
            let stubApiServiceProvider = MoyaProvider<APIService>(stubClosure: MoyaProvider.immediatelyStub)
            
            it("base url should be mockapi.com", closure: {
                expect(APIService.offer.baseURL).to(equal(URL(string: "https://mockapi.com")))
            })
            
            context("case offer", closure: {
                let offer = APIService.offer
                
                it("path should be offers", closure: {
                    expect(offer.path).to(equal("/offer"))
                })
                
                it("method should be get", closure: {
                    expect(offer.method).to(equal(Moya.Method.get))
                })
            })
            
            context("case provinces", closure: {
                let provinces = APIService.provinces
                
                it("path should be provinces", closure: {
                    expect(provinces.path).to(equal("/provinces"))
                })
                
                it("method should be get", closure: {
                    expect(provinces.method).to(equal(Moya.Method.get))
                })
            })
            
            context("case loans", closure: {
                let jsonString = JSONUtils.stringFromJSONFile("loans")
                let loans = APIService.loans(Loan(JSONString: jsonString)!)
                
                it("path should be loans", closure: {
                    expect(loans.path).to(equal("/loans"))
                })
                
                it("method should be post", closure: {
                    expect(loans.method).to(equal(Moya.Method.post))
                })
            })
            
        }
    }
    
}
