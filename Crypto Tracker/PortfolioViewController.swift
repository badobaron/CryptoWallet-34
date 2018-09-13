//
//  CryptoListViewController.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

class PortfolioViewController: UITableViewController {
    
    // MARK: Constants
    
    let headerHeight: CGFloat = 130.0
    let netWorthHeight: CGFloat = 45.0

    // MARK: Dependencies
    
    private var viewModel = PortfolioViewModel()
    
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
        
        setupBarButtons()
        
        setupBindings()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
}

// MARK: - UI Setup

extension PortfolioViewController {
    
    private func setupUI() {
        // TODO: Implement
        view.addSubview(headerView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        self.title = "Portfolio"
    }

    private func updateNetWorthAmount() {
        amountLabel.text = viewModel.netWorth.value
    }
    
    private func setupBarButtons() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(reportButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Secure App", style: .plain, target: self, action: #selector(secureButtonTapped))
    }
    
    // MARK: - Buttons handlers
    
    @objc private func reportButtonTapped() {
        // TODO: Implement
    }
    
    @objc private func secureButtonTapped() {
        // TODO: Implement
    }
    
}

// MARK: - Table view setup

extension PortfolioViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - Table view data source

extension PortfolioViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.portfolioItems.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        let cellData = viewModel.portfolioItems.value[indexPath.row]
        cell?.imageView?.image = cellData.image
        cell?.textLabel?.text = "\(cellData.symbol) - \(cellData.price)"
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

}

// MARK: - Table view delegate

extension PortfolioViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToCryptoDetails(for: indexPath.row, context: self.navigationController!)
    }
    
}

// MARK: - View model bindings

extension PortfolioViewController {
    
    private func setupBindings() {
        
        viewModel.portfolioItems.bind { (data) in
            self.tableView.reloadData()
        }
        
        viewModel.netWorth.bindAndCall { (amount) in
            self.updateNetWorthAmount()
        }
    }
        
}
