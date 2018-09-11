//
//  CryptoListItemModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

struct CryptoCurrency {
    var symbol: String
    var image: String
    var price: Double
    var amount: Double
    var priceHistory: [Double]
}
