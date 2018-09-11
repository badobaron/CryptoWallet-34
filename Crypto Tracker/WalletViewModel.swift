//
//  CryptoListViewModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

struct WalletItemViewModel {
    var symbol: String
    var image: UIImage
    var price: String
    var amount: String
}

class WalletViewModel {
    
    // Dependencies
    
    private lazy var dataSource = RemoteDataSource()
    private lazy var repository = CryptoTrackerRepository(dataSource: dataSource)
    
    // Bindable properties
    
    var walletItems = BindableProperty(value: [WalletItemViewModel]())
    var netWorth = BindableProperty(value: "Loading...")
    
    // Initialization
    
    init() {
        repository.data.bind { modelItems in
            
            var viewItems = [WalletItemViewModel]()
            
            for modelItem in modelItems {
                let viewItem = WalletItemViewModel(
                    symbol: modelItem.symbol,
                    image: UIImage(named:modelItem.image)!,
                    price: String(modelItem.price),
                    amount: String(modelItem.amount))
                viewItems.append(viewItem)
            }
            
            self.walletItems.value = viewItems
            
            //TODO: Implement calculation of net worth
            self.netWorth.value = "$9,999.99"
        }
    }
    
    func fetchData() {
        repository.fetchWalletItems(currency: "USD")
    }
    
}
