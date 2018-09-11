//
//  CryptoListRepository.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

class CryptoTrackerRepository {
    
    private var remoteInfoDataSource: InfoDataSource
    
    private(set) var data = BindableProperty(value: [CryptoCurrency]())
    
    init(dataSource: InfoDataSource) {
        self.remoteInfoDataSource = dataSource
    }
    
    func fetchWalletItems(currency: String) {
        
        // Some crypto currencies to track
        // TODO: make it dynamic
        let symbols = ["BCH", "BTC", "EOS", "ETH", "ETC",
                       "DASH", "DOGE", "ETH", "LTC", "MAID",
                       "NEO", "REP", "TRX", "XEM", "XMR",
                       "XRP"]
        
        var fetchedData = [CryptoCurrency]()
        
        DispatchQueue.global(qos: .background).async {
            self.remoteInfoDataSource.fetchPrices(for: symbols, currency: currency, { (prices) in
                for symbol in symbols {
                    if let price = prices[symbol] {
                        let item = CryptoCurrency(
                            symbol: symbol,
                            image: symbol.lowercased(),
                            price: price,
                            amount: 0.0,
                            priceHistory: [Double]())
                        fetchedData.append(item)
                    }
                }
                self.data.value = fetchedData
            })
        }
    }
}
