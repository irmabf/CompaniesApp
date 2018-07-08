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
    
    //  Setup UIAppearance proxy
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = .lightRed
    UINavigationBar.appearance().prefersLargeTitles = true
    
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    
    let companiesController = CompaniesController()
//    dummyViewController.view.backgroundColor = .blue
    
    let navController = CustomNavigationController(rootViewController: companiesController)
    window?.rootViewController  = navController
    
    return true
  }

}

