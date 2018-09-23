//
//  MonthlyIncome.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

enum MonthlyIncome: Int {
    case lessThan3Million = 1
    case from3MillionTo10Million = 3000001
    case over10Million = 10000001
    
    static func allTypeOfIncomes() -> [MonthlyIncome] {
        return [.lessThan3Million, .from3MillionTo10Million, .over10Million]
    }
    
    func description() -> String {
        switch self {
        case .lessThan3Million:
            return "Dưới 3 triệu đồng"
        case .from3MillionTo10Million:
            return "Từ 3 đến 10 triệu đồng"
        case .over10Million:
            return "Trên 10 triệu đồng"
        }
    }
    
}
