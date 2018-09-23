//
//  ProvinceList.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import ObjectMapper

struct ProvinceList: Mappable {
    
    var total: Int!
    var provinces: [String]!
    
    // MARK: JSON
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        total <- map["total"]
        provinces <- map["provinces_list"]
    }
    
}
