//
//  OfferSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class OfferSpec: QuickSpec {
    
    override func spec() {
        describe("An offer") {
            it("can be init by a JSON string", closure: {
                guard let offer = Offer(JSONString: JSONUtils.stringFromJSONFile("offer")) else {
                    return fail("Cannot parse loan object from json")
                }
                expect(offer.minimumLoanAmount).to(equal(30000000))
                expect(offer.maximumLoanAmount).to(equal(100000000))
                expect(offer.minimumTenor).to(equal(6))
                expect(offer.maximumTenor).to(equal(18))
                expect(offer.interestRate).to(equal(19.99))
                expect(offer.bank.name).to(equal("Vietcombank"))
                expect(offer.bank.logo).to(equal(URL(string: "https://www.vietcombank.com.vn/images/logo30.png")))
            })
        }
    }
    
}
