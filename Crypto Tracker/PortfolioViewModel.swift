//
//  CryptoListViewModel.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

struct PortfolioItemViewModel {
    var symbol: String
    var image: UIImage
    var price: String
    var amount: String
}

class PortfolioViewModel {
    
    // MARK: - Dependencies
    
    private lazy var dataSource = RemoteInfoDataSource()
    
    private lazy var repository = PortfolioRepository(dataSource: dataSource)
    
    // MARK: - Bindable properties
    
    var portfolioItems = BindableProperty(value: [PortfolioItemViewModel]())
    
    var netWorth = BindableProperty(value: NSLocalizedString("Loading...", comment: "Loading..."))
    
    // MARK: - Initialization
    
    init() {
        repository.delegate = self
    }
    
    // MARK: - API
    
    func fetchData() {
        repository.fetchPortfolioItems(currency: "USD")
    }
    
    // Move navigation out of ViewModel
    func navigateToCryptoDetails(for index: Int, context: UINavigationController) {
        let symbol = portfolioItems.value[index].symbol.lowercased()
        let cryptoDetailViewModel = CryptoDetailViewModel(for: symbol)
        let destinationViewController = CryptoDetailViewController()
        destinationViewController.viewModel = cryptoDetailViewModel
        context.pushViewController(destinationViewController, animated: true)
    }
    
}

// MARK: - Repository delegate

extension PortfolioViewModel: PortfolioRepositoryDelegate {
    
    internal func portfolioItemsFetched() {
        
        var viewItems = [PortfolioItemViewModel]()
        
        for modelItem in repository.data {
            let viewItem = PortfolioItemViewModel(
                symbol: modelItem.value.symbol,
                image: UIImage(named: modelItem.value.image)!,
                price: String(modelItem.value.price),
                amount: String(modelItem.value.amount))
            viewItems.append(viewItem)
        }
        
        self.portfolioItems.value = viewItems
        
        //TODO: Implement calculation of net worth
        self.netWorth.value = "$9,999.99"
    }
    
}
