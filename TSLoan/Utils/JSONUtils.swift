//
//  JSONUtils.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Foundation

class JSONUtils {
    class func dataFromJSONFile(_ filename: String) -> Data {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return Data()
            }
        }
        
        return Data()
    }
    
    class func stringFromJSONFile(_ filename: String) -> String {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let string = try String(contentsOfFile: path)
                return string
            } catch {
                return ""
            }
        }
        
        return ""
    }
}
