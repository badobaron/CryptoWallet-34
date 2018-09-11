//
//  CryptoDetailViewController.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/11/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit
import SwiftChart

class CryptoDetailViewController: UIViewController {
    
    // MARK: - Constants
    
    private let chartHeight: CGFloat = 300.0
    private let imageSize: CGFloat = 100.0
    private let priceLabelHeight: CGFloat = 25.0

    // MARK: - Dependencies
    
    var viewModel: CryptoDetailViewModel!
    
    // MARK: - Subviews
    
    var chart = Chart()
    var cryptoImage = UIImageView()
    var priceLabel = UILabel()
    var youOwnLabel = UILabel()
    var worthLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchData()
    }

}

// MARK: - UI Setup

extension CryptoDetailViewController {
    
    private func setupUI() {

        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        
        setupChartView()
        setupCryptoImageView()
        setupPriceLabel()
        setupYouOwnLabel()
        setupWorthLabel()
    }
    
    private func setupChartView() {
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        chart.yLabelsFormatter = { $1.toMoneyString() }
        chart.xLabels = [30, 25, 20, 15, 10, 5, 0]
        chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d" }
        view.addSubview(chart)
    }
    
    private func setupCryptoImageView() {
        cryptoImage.frame = CGRect(x: view.frame.size.width / 2 - imageSize / 2, y: chartHeight, width: imageSize, height: imageSize)
        cryptoImage.image = viewModel.image.value
        view.addSubview(cryptoImage)
    }
    
    private func setupPriceLabel() {
        priceLabel.frame = CGRect(x: 0, y: chartHeight + imageSize, width: view.frame.size.width, height: priceLabelHeight)
        priceLabel.textAlignment = .center
        view.addSubview(priceLabel)
    }
    
    private func setupYouOwnLabel() {
        youOwnLabel.frame = CGRect(x: 0, y: chartHeight + imageSize + priceLabelHeight * 2, width: view.frame.size.width, height: priceLabelHeight)
        youOwnLabel.textAlignment = .center
        youOwnLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(youOwnLabel)
    }
    
    private func setupWorthLabel() {
        worthLabel.frame = CGRect(x: 0, y: chartHeight + imageSize + priceLabelHeight * 3, width: view.frame.size.width, height: priceLabelHeight)
        worthLabel.textAlignment = .center
        worthLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(worthLabel)
    }
}

// MARK: - View model bindings

extension CryptoDetailViewController {
    
    private func setupBindings() {
        
        viewModel.priceHistory.bindAndCall { (priceHistory) in
            let series = ChartSeries(self.viewModel.priceHistory.value)
            series.area = true
            self.chart.add(series)
        }
        
        viewModel.price.bindAndCall { (price) in
            self.priceLabel.text = self.viewModel.price.value
        }
        
        viewModel.amount.bindAndCall { (amount) in
            self.updateYouOwnLabel()
        }

        viewModel.symbol.bindAndCall { (symbol) in
            self.title = self.viewModel.symbol.value.uppercased()
            self.updateYouOwnLabel()
        }
        
        viewModel.amountAsMoney.bindAndCall { (amountAsMoney) in
            self.worthLabel.text = self.viewModel.amountAsMoney.value
        }
        
    }
    
    private func updateYouOwnLabel() {
        youOwnLabel.text = "You own: \(self.viewModel.amount.value) \(self.viewModel.symbol.value.uppercased())"
    }
    
}
