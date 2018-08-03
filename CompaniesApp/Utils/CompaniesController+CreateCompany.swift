//
//  CompaniesController+CreateCompany.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 04/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
  //specify our extension methods here...
  func didEditCompany(company: Company) {
    // update my tableview somehow
    let row = companies.index(of: company)
    let reloadIndexPath = IndexPath(row: row!, section: 0)
    tableView.reloadRows(at: [reloadIndexPath], with: .middle)
  }
  
  
  func didAddCompany(company: Company) {
    companies.append(company)
    let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)
  }
}
