//
//  Loan.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import ObjectMapper

struct Loan: Mappable {

    var id: Int?
    var phoneNumber: String!
    var fullName: String!
    var nationalIdNumber: String!
    var monthlyIncome: Int!
    var province: String!
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        phoneNumber <- map["phone_number"]
        fullName <- map["full_name"]
        nationalIdNumber <- map["national_id_number"]
        monthlyIncome <- map["monthly_income"]
        province <- map["province"]
    }
    
}
