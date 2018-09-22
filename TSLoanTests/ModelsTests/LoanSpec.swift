//
//  LoadTests.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class LoadSpec: QuickSpec {
    
    override func spec() {
        describe("A loan") {
            it("can be init by a JSON string", closure: {
                guard let loan = Loan(JSONString: JSONUtils.stringFromJSONFile("loans")) else {
                    return fail("Cannot parse loan object from json")
                }
                expect(loan.id).to(equal(1))
                expect(loan.phoneNumber).to(equal("0987000001"))
                expect(loan.fullName).to(equal("Nguyễn Văn Tuấn"))
                expect(loan.nationalIdNumber).to(equal("111111111"))
                expect(loan.monthlyIncome).to(equal(3000001))
                expect(loan.province).to(equal("An Giang"))
            })
        }
    }

}
