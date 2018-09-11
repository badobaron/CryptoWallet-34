//
//  CryptoListViewController.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

class CryptoListViewController: UITableViewController {

    private var viewModel = CryptoListViewModel()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.listItems.bind { (data) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
}

// MARK: - UI setup

extension CryptoListViewController {
    
    private func setupUI() {
        // TODO: Implement
        setupTableCell()
    }
    
}

// MARK: - Table view setup

extension CryptoListViewController {
    
    private func setupTableCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
}

// MARK: - Table view data source

extension CryptoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        let cellData = viewModel.listItems.value[indexPath.row]
        cell?.imageView?.image = cellData.image
        cell?.textLabel?.text = "\(cellData.symbol) - \(cellData.price)"
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

}

// MARK: - Table view delegate

extension CryptoListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Implement
    }
    
}
