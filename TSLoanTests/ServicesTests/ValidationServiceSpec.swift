//
//  ValidationServiceSpec.swift
//  TSLoanTests
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Quick
import Nimble

@testable import TSLoan

class ValidationServiceSpec: QuickSpec {
    
    override func spec() {
        describe("Validation service") {
            let sut = TSLoanValidationService()
            
            context("validate phone number", closure: {
                it("should validate phone numer", closure: { [weak self] in
                    let validPrefix = ["0120", "0121", "0122", "0123", "0124", "0125", "0126", "0127", "0128", "0129", "0162", "0163", "0164", "0165", "0166", "0167", "0168", "0169", "0186", "0188", "0199", "086", "088", "089", "090", "091", "092", "093", "094", "095", "096", "097", "098", "099"]
                    let validSuffix = "1234567"
                    let invalidSuffix = "a123456"
                    for number in 0..<1000 {
                        let prefix = "\(number)"
                        if self?.checkPrefix(for: prefix, with: validPrefix) ?? false {
                            expect(sut.validatePhoneNumber(prefix + validSuffix)).toEventually(beTruthy())
                        } else {
                            expect(sut.validatePhoneNumber(prefix + validSuffix)).toEventually(beFalsy())
                        }
                        expect(sut.validatePhoneNumber(prefix + invalidSuffix)).toEventually(beFalsy())
                    }
                })
            })
            
            context("validate name", closure: {
                it("should validate name", closure: {
                    expect(sut.validateName("123")).toEventually(beFalsy())
                    expect(sut.validateName("a1")).toEventually(beFalsy())
                    expect(sut.validateName("1a")).toEventually(beFalsy())
                    expect(sut.validateName("a")).toEventually(beTruthy())
                })
            })
            
            context("validate national ID number", closure: {
                it("should validate national ID number", closure: {
                    expect(sut.validateNationalIDNumber("123")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("a1")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("1a")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("a")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("12345678")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("1234567890")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("12345678901")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("1234567890123")).toEventually(beFalsy())
                    expect(sut.validateNationalIDNumber("123456789")).toEventually(beTruthy())
                    expect(sut.validateNationalIDNumber("123456789012")).toEventually(beTruthy())
                })
            })
        }
    }
    
    private func checkPrefix(for string: String, with arrayPrefixes: [String]) -> Bool {
        for prefix in arrayPrefixes {
            if string.hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
    
}
