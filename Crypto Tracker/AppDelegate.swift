//
//  AppDelegate.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // TODO: Move to configuration file
    let appIsSecuredKey = "appIsSecured"
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let appIsSecured = UserDefaults.standard.bool(forKey: appIsSecuredKey)
        
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) && appIsSecured {
            // Device support biometrics authentication & the app is secured;
            // let's go authenticate the user...
            let authVC = AuthViewController()
            window?.rootViewController = authVC
            
        } else {
            // Either the device does not support biometrics authentication or
            // the app is not secured;
            let viewController = PortfolioViewController()
            let navigationVC = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationVC
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

