//
//  AppDelegate.swift
//  Essentialss
//
//  Created by QTS Coder on 7/17/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var totalPrice = 0.0
    var taxCard = ""
    var paymentObj = PaymentObj.init()
    var isPaymentSuccess = false
    var arrHomes = [HomeObj]()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(1)
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        return true
    }

}

