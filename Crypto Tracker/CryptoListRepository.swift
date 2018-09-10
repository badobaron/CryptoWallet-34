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
    
    private(set) var data = BindableProperty(value: [CryptoListItemModel]())
    
    init(dataSource: CryptoDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchData(currency: String) {
        
        let symbols = ["BTC", "ETH", "LTC"]
        
        var fetchedData = [CryptoListItemModel]()
        
        DispatchQueue.global(qos: .background).async {
            self.dataSource.prices(for: symbols, currency: currency, { (prices) in
                for symbol in symbols {
                    if let price = prices[symbol] {
                        let item = CryptoListItemModel(
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
