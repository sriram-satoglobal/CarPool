//
//  AppDelegate.swift
//  CarPoolDemo
//
//  Created by Tejaswi Yarlagadda on 3/23/17.
//  Copyright © 2017 Demo Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        CPDataHandler.shared.setUpData {
            print("Data Loaded Successfully.")
        }
        return true
    }
}

