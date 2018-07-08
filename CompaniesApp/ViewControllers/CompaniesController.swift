//
//  ViewController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
  
  let cellId = "cellId"

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupNavigationStyle()
    
    setupTableViewStyle()
  }
  
//  Overrides
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .tealColor
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
//  Custom functions
  @objc fileprivate func handleAddCompany() {
    print("Company added")
  }
  
  //  Custom functions for styles
  fileprivate func setupTableViewStyle() {
   
    
//    tableView.separatorStyle = .none
//    This code removes the separator from the part of the tableView without cells
    
    tableView.tableFooterView = UIView() // blank UIView
    
    tableView.backgroundColor =  .darkBlue
  }

  fileprivate func setupNavigationStyle() {
    
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = .lightRed
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
  }
}

















