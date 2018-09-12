//
//  CryptoDetailsRepository.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/12/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

protocol CryptoDetailsRepositoryDelegate {
    
    func detailsFetched(cryptoCurrency: CryptoCurrency)
    
    func priceHistoryFetched(priceHistory: [Double])
}

class CryptoDetailsRepository {
    
    // MARK: - Constants
    
    let numOfDaysForHistoryChart = 30
    
    // MARK: - Dependencies
    
    private var remoteInfoDataSource: InfoDataSource
    
    // MARK: - Properties
    
    var delegate: CryptoDetailsRepositoryDelegate!
    
    // MARK: - Initialization
    
    init(dataSource: InfoDataSource) {
        self.remoteInfoDataSource = dataSource
    }
    
    // MARK: - API
    
    func fetchPriceHistory(for symbol: String, in currency: String) {
        
        DispatchQueue.global(qos: .background).async {
            self.remoteInfoDataSource.fetchPriceHistory(for: symbol, in: currency, days: self.numOfDaysForHistoryChart, { (priceHistory) in
                DispatchQueue.main.async {
                    self.delegate.priceHistoryFetched(priceHistory: priceHistory)
                }
                
            })
        }
    }
    
    func fetchDetails(for symbol: String, in currency: String) {
        
        DispatchQueue.global(qos: .background).async {
            self.remoteInfoDataSource.fetchPrices(for: [symbol], in: currency, { (prices) in
                
                if let price = prices[symbol] {
                    let item = CryptoCurrency(
                        symbol: symbol,
                        image: symbol.lowercased(),
                        price: price,
                        amount: 0.0,
                        priceHistory: [Double]())
                    DispatchQueue.main.async {
                        self.delegate.detailsFetched(cryptoCurrency: item)
                    }
                }
                
            })
        }
        
    }
    
}
