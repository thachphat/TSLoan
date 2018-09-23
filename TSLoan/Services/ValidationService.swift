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
        // TODO: update this function
        return true
    }
    
    func validateName(_ name: String) -> Bool {
        // TODO: update this function
        return true
    }
    
    func validateNationalIDNumber(_ nationalIDNumber: String) -> Bool {
        // TODO: update this function
        return true
    }
}
