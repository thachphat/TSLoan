//
//  ValidationService.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Foundation

protocol ValidationService {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool
    func validateName(_ name: String) -> Bool
    func validateNationalIDNumber(_ nationalIDNumber: String) -> Bool
}

class TSLoanValidationService: ValidationService {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        return validate(phoneNumber, with: "^(?:012\\d|016[2-9]|0186|0188|0199|08[689]|09\\d)\\d{7}+$")
    }
    
    func validateName(_ name: String) -> Bool {
        return validate(name, with: "^[a-z ,.'-]+$")
    }
    
    func validateNationalIDNumber(_ nationalIDNumber: String) -> Bool {
        return validate(nationalIDNumber, with: "^(?:\\d{9}|\\d{12})$")
    }
    
    private func validate(_ string: String, with regex: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
        guard let matches = regex?.matches(in: string, options: [], range: NSRange(location: 0, length: string.count)) else {
            return false
        }
        return matches.count > 0
    }
}
