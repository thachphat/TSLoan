//
//  BankSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class BankSpec: QuickSpec {
    
    override func spec() {
        describe("A bank") {
            it("can be init by a JSON string", closure: {
                guard let bank = Bank(JSONString: "{\"name\": \"My Bank\",\"logo\": \"https://www.vietcombank.com.vn/images/logo30.png\"}") else {
                    return fail("Cannot parse loan object from json")
                }
                
                expect(bank.name).to(equal("My Bank"))
                expect(bank.logo).to(equal(URL(string: "https://www.vietcombank.com.vn/images/logo30.png")))
            })
        }
    }
    
}
