//
//  ViewController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    
    setupNavigationStyle()
  }
  
  @objc fileprivate func handleAddCompany() {
    print("Company added")
  }
  
  fileprivate func setupNavigationStyle() {
    
    navigationController?.navigationBar.isTranslucent = false
    let lightRed = UIColor.rgb(red: 247, green: 66, blue: 82)
    
    navigationController?.navigationBar.barTintColor = lightRed
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
  }
}

















