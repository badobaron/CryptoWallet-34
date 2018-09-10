//
//  BindableProperty.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import Foundation

class BindableProperty<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    func bindAndCall(_ listener: @escaping Listener) {
        bind(listener)
        self.listener?(value)
    }
    
}
