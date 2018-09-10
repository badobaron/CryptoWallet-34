//
//  CryptoListViewModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

struct CryptoListItemViewModel {
    var symbol: String
    var imageName: String
    var price: String
    var amount: String
}

class CryptoListViewModel {
    
    // Bindable properties
    
    var listItems = BindableProperty(value: [CryptoListItemViewModel]())
    
    // Dependencies
    
    private lazy var dataSource = CryptoRemoteDataSource()
    private lazy var repository = CryptoListRepository(dataSource: dataSource)
    
    // Initialization
    
    init() {
        repository.data.bind { modelItems in
            
            var viewItems = [CryptoListItemViewModel]()
            
            for modelItem in modelItems {
                let viewItem = CryptoListItemViewModel(
                    symbol: modelItem.symbol,
                    imageName: modelItem.image,
                    price: String(modelItem.price),
                    amount: String(modelItem.amount))
                viewItems.append(viewItem)
            }
            
            self.listItems.value = viewItems
        }
    }
    
    func fetchData() {
        repository.fetchData(currency: "USD")
    }
    
}
