//
//  JSONUtilsSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class JSONUtilsSpec: QuickSpec {
    
    override func spec() {
        describe("JSON Utils") {
            context("get data from json file", closure: {
                it("can get data from file", closure: {
                    let data = JSONUtils.dataFromJSONFile("loans")
                    let expectedData = "{\"id\": 1,\"phone_number\": \"0987000001\",\"full_name\": \"Nguyễn Văn Tuấn\",\"national_id_number\": \"111111111\",\"monthly_income\": 3000001,\"province\": \"An Giang\"}\n".data(using: .utf8)
                    
                    expect(data).to(equal(expectedData))
                })
                
                it("should return empty data if file.json not exist", closure: {
                    let data = JSONUtils.dataFromJSONFile("abc")
                    
                    expect(data.isEmpty).toEventually(beTruthy())
                })
                
                it("should return empty data if file is not json", closure: {
                    let data = JSONUtils.dataFromJSONFile("empty")
                    
                    expect(data.isEmpty).toEventually(beTruthy())
                })
            })
            
            context("get string from json file", closure: {
                it("can get string from file", closure: {
                    let string = JSONUtils.stringFromJSONFile("loans")
                    let expectedString = "{\"id\": 1,\"phone_number\": \"0987000001\",\"full_name\": \"Nguyễn Văn Tuấn\",\"national_id_number\": \"111111111\",\"monthly_income\": 3000001,\"province\": \"An Giang\"}\n"
                    
                    expect(string).to(equal(expectedString))
                })
                
                it("should return empty string if file.json not exist", closure: {
                    let string = JSONUtils.stringFromJSONFile("abc")
                    
                    expect(string.isEmpty).toEventually(beTruthy())
                })
                
                it("should return empty data if file is not json", closure: {
                    let string = JSONUtils.stringFromJSONFile("empty")
                    
                    expect(string.isEmpty).toEventually(beTruthy())
                })
            })
        }
    }
    
}
