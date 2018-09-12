//
//  CryptoListRepository.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

protocol PortfolioRepositoryDelegate {
    func portfolioItemsFetched()
}

class PortfolioRepository {
    
    // MARK: - Constants
    
    // Some crypto currencies to track
    let symbols = ["BCH", "BTC", "EOS", "ETH", "ETC",
                   "DASH", "DOGE", "ETH", "LTC", "MAID",
                   "NEO", "REP", "TRX", "XEM", "XMR",
                   "XRP"]
    
    // MARK: - Dependencies
    
    private var remoteInfoDataSource: InfoDataSource
    
    // MARK: - Properties
    
    private(set) var data = [String:CryptoCurrency]()
    
    var delegate: PortfolioRepositoryDelegate!
    
    // MARK: - Initialization
    
    init(dataSource: InfoDataSource) {
        self.remoteInfoDataSource = dataSource
    }
    
    // MARK: - API
    
    func fetchPortfolioItems(currency: String) {
        
        var newData = [String:CryptoCurrency]()
        
        DispatchQueue.global(qos: .background).async {
            self.remoteInfoDataSource.fetchPrices(for: self.symbols, in: currency, { (prices) in
                
                for symbol in self.symbols {
                    if let price = prices[symbol] {
                        let item = CryptoCurrency(
                            symbol: symbol,
                            image: symbol.lowercased(),
                            price: price,
                            amount: 0.0,
                            priceHistory: [Double]())
                        newData[symbol] = item
                    }
                }
                self.data = newData
                self.delegate.portfolioItemsFetched()
            })
        }
    }
    
}
