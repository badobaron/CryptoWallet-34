//
//  CryptoListRepository.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

class CryptoListRepository {
    
    private var dataSource: CryptoDataSource
    
    private(set) var data = BindableProperty(value: [CryptoCoin]())
    
    init(dataSource: CryptoDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchData(currency: String) {
        
        let symbols = ["BCH", "BTC", "EOS", "ETH", "ETC",
                       "DASH", "DOGE", "ETH", "LTC", "MAID",
                       "NEO", "REP", "TRX", "XEM", "XMR", "XRP"]
        
        var fetchedData = [CryptoCoin]()
        
        DispatchQueue.global(qos: .background).async {
            self.dataSource.prices(for: symbols, currency: currency, { (prices) in
                for symbol in symbols {
                    if let price = prices[symbol] {
                        let item = CryptoCoin(
                            symbol: symbol,
                            image: symbol.lowercased(),
                            price: price,
                            amount: 0.0)
                        fetchedData.append(item)
                    }
                }
                self.data.value = fetchedData
            })
        }
    }
}
