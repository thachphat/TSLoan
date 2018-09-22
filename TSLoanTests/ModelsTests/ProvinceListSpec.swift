//
//  ProvinceListSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class ProvinceListSpec: QuickSpec {
    
    override func spec() {
        describe("A province list") {
            it("can be init by a JSON string", closure: {
                guard let provinceList = ProvinceList(JSONString: JSONUtils.stringFromJSONFile("provinces")) else {
                    return fail("Cannot parse loan object from json")
                }
                
                expect(provinceList.total).to(equal(10))
                expect(provinceList.provinces).to(equal(["An Giang",
                                                         "Bắc Giang",
                                                         "Bắc Kạn",
                                                         "Bạc Liêu",
                                                         "Bắc Ninh",
                                                         "Bà Rịa - Vũng Tàu",
                                                         "Bến Tre",
                                                         "Bình Định",
                                                         "Bình Dương",
                                                         "Bình Phước"]))
            })
        }
    }
    
}
