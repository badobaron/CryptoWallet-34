//
//  CryptoRemoteDataSource.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation
import Alamofire

class RemoteInfoDataSource: InfoDataSource {
    
    // MARK: - Constants
    
    private let baseUrl = "https://min-api.cryptocompare.com/data"
    
    // MARK: - API - InfoDataSource protocol
    
    func fetchPrices(for symbols: [String], in currency: String, _ callback: @escaping ([String : Double]) -> ()) {

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
    
    func fetchPriceHistory(for symbol: String, in currency: String, days: Int, _ callback: @escaping ([Double]) -> ()) {
        
        var priceHistory = [Double]()
        
        let requestUrlString = "\(baseUrl)/histoday?fsym=\(symbol.uppercased())&tsym=\(currency)&limit=\(days)"
        Alamofire.request(requestUrlString).responseJSON { (response) in
            
            if let json = response.result.value as? [String:Any] {
                if let pricesJSON = json["Data"] as? [[String:Double]] {
                    for priceJSON in pricesJSON {
                        if let closePrice = priceJSON["close"] {
                            priceHistory.append(closePrice)
                            
                        }
                    }
                }
            }
            callback(priceHistory)
        }
    }
    
}
