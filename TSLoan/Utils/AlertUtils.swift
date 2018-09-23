//
//  AlertUtils.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/23/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import UIKit

class AlertUtils {
    class func showPromptMessage(_ message: String, from viewController: UIViewController?) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
