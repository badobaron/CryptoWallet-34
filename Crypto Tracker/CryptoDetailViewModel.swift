//
//  CryptoDetailViewModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/11/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

class CryptoDetailViewModel {

    // Dependencies
    
    private lazy var dataSource = RemoteInfoDataSource()
    private lazy var repository = CryptoTrackerRepository(dataSource: dataSource)
    
    // Bindable properties
    
    var symbol = BindableProperty(value: "")
    var image = BindableProperty(value: UIImage())
    var price = BindableProperty(value: "Loading...")
    var amount = BindableProperty(value: "Loading...")
    var amountAsMoney = BindableProperty(value: "Loading...")
    var priceHistory = BindableProperty(value: [Double]())

    // Initialization
    
    init() {
        setupBindings()
    }
    
    func fetchData() {
        // TODO: Fetch data from repository
        fetchFakeData()
    }
    
    private func fetchFakeData() {
        symbol.value = "BTC"
        image.value = UIImage(named: "btc")!
        price.value = "$6,297.58"
        amount.value = "0.567"
        amountAsMoney.value = "$3,570.73"
        priceHistory.value = Array(repeating: 6000.00, count: 30)
    }
    
}

// MARK: - Repository bindings

extension CryptoDetailViewModel {
    
    private func setupBindings() {
        // TODO: Bind to repo data
    }
    
}
