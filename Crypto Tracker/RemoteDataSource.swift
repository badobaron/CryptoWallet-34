//
//  CryptoRemoteDataSource.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation
import Alamofire

class RemoteDataSource: DataSource {
    
    private let baseUrl = "https://min-api.cryptocompare.com/data"
    
    func prices(for symbols: [String], currency: String, _ callback: @escaping ([String : Double]) -> ()) {

        var listOfSymbols = ""
        
        for symbol in symbols {
            listOfSymbols += symbol.uppercased()
            if symbol != symbols.last {
                listOfSymbols += ","
            }
        }
        
        var prices = [String:Double]()
        
        let requestUrlString = "\(baseUrl)/pricemulti?fsyms=\(listOfSymbols)&tsyms=\(currency)"
        Alamofire.request(requestUrlString).responseJSON { (response) in
            
            if let json = response.result.value as? [String:Any] {
                for symbol in symbols {
                    if let priceJSON = json[symbol.uppercased()] as? [String:Double]{
                        if let newPrice = priceJSON[currency] {
                            prices[symbol] = newPrice
                        }
                    }
                }
            }
            callback(prices)
        }

    }
    
}
