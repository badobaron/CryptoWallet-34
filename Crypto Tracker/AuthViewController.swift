//
//  AuthViewController.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 13/9/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        authenticateUserAndGo()
    }
    
    private func authenticateUserAndGo() {
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: NSLocalizedString("Your crypto portfolio is protected by biometrics", comment: "Your crypto portfolio is protected by biometrics")) { (success, error) in
            
            if success {
                // Authentication takes places in background;
                // move to main thread to do UI stuff
                DispatchQueue.main.async {
                    let porfolioVC = PortfolioViewController()
                    let navigationVC = UINavigationController(rootViewController: porfolioVC)
                    self.present(navigationVC, animated: true, completion: nil)
                }
            } else {
                // authentication failed, retry...
                self.authenticateUserAndGo()
            }
        }
    }
}
