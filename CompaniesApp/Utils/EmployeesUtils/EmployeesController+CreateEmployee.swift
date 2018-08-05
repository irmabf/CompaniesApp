//
//  EmployeesController+CreateEmployee.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 05/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
  /*
   func didAddCompany(company: Company) {
   companies.append(company)
   let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
   tableView.insertRows(at: [newIndexPath], with: .automatic)
   }*/
  func didAddEmployee(employee: Employee) {
    employees.append(employee)
    let newIndexPath = IndexPath(row: employees.count - 1, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)
  }
}



