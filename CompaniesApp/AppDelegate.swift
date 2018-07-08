//
//  AppDelegate.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    
    let companiesController = CompaniesController()
//    dummyViewController.view.backgroundColor = .blue
    
    let navController = CustomNavigationController(rootViewController: companiesController)
    window?.rootViewController  = navController
    
    return true
  }

}

