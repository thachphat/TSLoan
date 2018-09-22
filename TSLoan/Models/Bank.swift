//
//  Bank.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import ObjectMapper

struct Bank: Mappable {
    
    var name: String!
    var logo: URL!
    
    // MARK: JSON
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        logo <- (map["logo"], URLTransform())
    }
    
}
