//
//  CryptoDetailViewModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/11/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

class CryptoDetailViewModel {

    // MARK: - Dependencies
    
    private lazy var dataSource = RemoteInfoDataSource()
    
    private lazy var repository = CryptoDetailsRepository(dataSource: dataSource)
    
    // MARK: - Properties
    
    private var id: String
    
    // MARK: - Bindable properties
    
    var symbol = BindableProperty(value: "")
    var image = BindableProperty(value: UIImage())
    var price = BindableProperty(value: "Loading...")
    var amount = BindableProperty(value: "Loading...")
    var amountAsMoney = BindableProperty(value: "Loading...")
    var priceHistory = BindableProperty(value: [Double]())

    // MARK: - Initialization
    
    init(for symbol: String) {
        self.id = symbol
        repository.delegate = self
    }
    
    // MARK: - API
    
    func fetchData() {
        repository.fetchDetails(for: id, in: "USD")
        repository.fetchPriceHistory(for: id, in: "USD")
    }
    
}

// MARK: - Repository delegate

extension CryptoDetailViewModel: CryptoDetailsRepositoryDelegate {
    
    func detailsFetched(cryptoCurrency: CryptoCurrency) {
        symbol.value = cryptoCurrency.symbol.uppercased()
        image.value = UIImage(named: cryptoCurrency.symbol.lowercased())!
        price.value = String(cryptoCurrency.price)
        amount.value = "0.00"
        amountAsMoney.value = "$0.00"
    }
    
    func priceHistoryFetched(priceHistory: [Double]) {
        self.priceHistory.value = priceHistory
    }
    
}
