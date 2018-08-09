//
//  EmployeesController+CreateEmployee.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 05/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
//this is called when we dismiss creation
//  func didAddEmployee(employee: Employee) {
////    employees.append(employee)
//    fetchEmployees()
////    let newIndexPath = IndexPath(row: employees.count - 1, section: 0)
////    tableView.insertRows(at: [newIndexPath], with: .automatic)
//    tableView.reloadData()
//  }
  
  //This function is called when we dismiss the employee creation screen
  func didAddEmployee(employee: Employee) {
    //what is the insertion index path
    guard let section = employeeTypes.index(of: employee.type!) else { return }
    //what is my row
    let row = allEmployees[section].count
    
    let insertionIndexPath = IndexPath(row: row, section: section)
    
    allEmployees[section].append(employee)
    
    tableView.insertRows(at: [insertionIndexPath], with: .middle)
  }
}



