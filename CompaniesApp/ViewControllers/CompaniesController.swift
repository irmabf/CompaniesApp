//
//  ViewController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
  
  let companies = [
    Company(name: "Apple", founded: Date()),
    Company(name: "Google", founded: Date()),
    Company(name: "Facebook", founded: Date())
  ]
  
  let cellId = "cellId"

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupNavigationItems()
    
    setupTableViewStyle()
  }
  
  //  Custom functions
  
  @objc func handleAddCompany() {
    let createCompanyController = CreateCompanyController()
    let navController = CustomNavigationController(rootViewController: createCompanyController)
    present(navController, animated: true, completion: nil)
  }
  
//  Overrides
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    let company = companies[indexPath.row]
    
    cell.backgroundColor = .tealColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    cell.textLabel?.text = company.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return companies.count
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .lightBlue
    return view
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
}

















