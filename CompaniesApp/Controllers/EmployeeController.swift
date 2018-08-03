//
//  EmployeeController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 04/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController{
  
  var company: Company?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = company?.name
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.backgroundColor = .darkBlue
    
    setupPlusButtonInNavBar(selector: #selector(handleAdd))
    
  }
  @objc private func handleAdd() {
    //Create the view controller
    let createEmployeeController = CreateEmployeeController()
    //Create a navigation controller and wrap the vc in it
    let navController = UINavigationController(rootViewController: createEmployeeController)
    present(navController, animated: true, completion: nil)
  }

}
