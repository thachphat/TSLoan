//
//  Offer.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import ObjectMapper

struct Offer: Mappable {

    var minimumLoanAmount: Double!
    var maximumLoanAmount: Double!
    var minimumTenor: Int!
    var maximumTenor: Int!
    var interestRate: Double!
    var bank: Bank!
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        minimumLoanAmount <- map["min_amount"]
        maximumLoanAmount <- map["max_amount"]
        minimumTenor <- map["min_tenor"]
        maximumTenor <- map["max_tenor"]
        interestRate <- map["interest_rate"]
        bank <- map["bank"]
    }
    
}
