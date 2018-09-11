//
//  AppDelegate.swift
//  Crypto Tracker
//
//  Created by Jero Sanchez on 9/10/18.
//  Copyright © 2018 Jero Sanchez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = WalletViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }


}

