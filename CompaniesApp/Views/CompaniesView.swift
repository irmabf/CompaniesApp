//
//  File.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension CompaniesController {
  //  Custom functions for styles
   func setupTableViewStyle() {
    //    tableView.separatorStyle = .none
    //    This code removes the separator from the part of the tableView without cells
    tableView.tableFooterView = UIView() // blank UIView
    tableView.backgroundColor =  .darkBlue
    tableView.separatorColor = .white
  }

  func setupNavigationItems() {
    navigationItem.title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
  }
}
