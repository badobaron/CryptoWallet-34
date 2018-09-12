//
//  CryptoDataSource.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

protocol InfoDataSource {
    
    func fetchPrices(for symbols: [String], in currency: String, _ callback: @escaping ([String:Double]) -> ())
    
    func fetchPriceHistory(for symbol: String, in currency: String, days: Int, _ callback: @escaping ([Double]) -> ())
}
