//
//  CryptoListViewController.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

class WalletViewController: UITableViewController {
    
    // MARK: Constants
    
    let headerHeight: CGFloat = 130.0
    let netWorthHeight: CGFloat = 45.0

    // MARK: Dependencies
    
    private var viewModel = WalletViewModel()
    
    // MARK: Subviews
    
    private var amountLabel = UILabel()
    
    private var headerView: UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = .white
        
        let netWorthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: netWorthHeight))
        netWorthLabel.text = "My Crypto Net Worth:"
        netWorthLabel.textAlignment = .center
        headerView.addSubview(netWorthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 45.0)
        headerView.addSubview(amountLabel)
        
        return headerView
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
}

// MARK: - UI Setup

extension WalletViewController {
    
    private func setupUI() {
        // TODO: Implement
        view.addSubview(headerView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        self.title = "Wallet"
    }

    private func updateNetWorthAmount() {
        amountLabel.text = viewModel.netWorth.value
    }
}

// MARK: - Table view setup

extension WalletViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - Table view data source

extension WalletViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.walletItems.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        let cellData = viewModel.walletItems.value[indexPath.row]
        cell?.imageView?.image = cellData.image
        cell?.textLabel?.text = "\(cellData.symbol) - \(cellData.price)"
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

}

// MARK: - Table view delegate

extension WalletViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Move assembly of crypto detail VC to an assembly layer
        let cryptoDetailViewModel = CryptoDetailViewModel()
        let destinationViewController = CryptoDetailViewController()
        destinationViewController.viewModel = cryptoDetailViewModel
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

// MARK: - View model bindings

extension WalletViewController {
    
    private func setupBindings() {
        
        viewModel.walletItems.bind { (data) in
            self.tableView.reloadData()
        }
        
        viewModel.netWorth.bindAndCall { (amount) in
            self.updateNetWorthAmount()
        }
    }
        
}
