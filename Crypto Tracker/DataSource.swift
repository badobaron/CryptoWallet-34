//
//  CryptoDataSource.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

protocol DataSource {
    func prices(for symbols: [String], currency: String, _ callback: @escaping ([String:Double]) -> ())
}
