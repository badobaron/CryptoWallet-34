//
//  Double+Extension.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/11/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

extension Double {
    
    func toMoneyString() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        if let fancyPrice = formatter.string(from: NSNumber(floatLiteral: self)) {
            return fancyPrice
        } else {
            return "ERROR"
        }
    }
}
