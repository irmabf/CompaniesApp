//
//  EmployeeController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 04/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
 
  //MARK:- Attributes
  
  var company: Company?
  let cellId = "cellId"
  
  //An array of arrays of employees
  var allEmployees = [[Employee]]()
  
  var employeeTypes = [
    EmployeeType.Executive.rawValue,
    EmployeeType.SeniorManagement.rawValue,
    EmployeeType.Staff.rawValue
  ]
  
  //MARK:- Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = company?.name
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchEmployees()
    
    tableView.backgroundColor = .darkBlue
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupPlusButtonInNavBar(selector: #selector(handleAdd))
    
  }
  
  //MARK:- TableView Methods
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()

    label.text = employeeTypes[section]
    
    label.backgroundColor = UIColor.lightBlue
    label.textColor = UIColor.darkBlue
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return allEmployees.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allEmployees[section].count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    //Pull the employee from the employees array with the indexpath.row as the index of the array
//    let employee = indexPath.section == 0 ? shortNameEmployees[indexPath.row] : longNameEmployees[indexPath.row]
    
    let employee = allEmployees[indexPath.section][indexPath.row]

    cell.textLabel?.text = employee.name
    
    if let birthday = employee.employeeInformation?.birthday {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM dd, yyyy"
      
      cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
    }

    cell.backgroundColor = UIColor.tealColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    
    return cell
  }
 
 
//MARK:- Custom functions

  func fetchEmployees() {
    guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
    
    allEmployees = []
    
    //Let´s use an array and loop to filter
    employeeTypes.forEach { (employeeType) in
      //construct muy allEmployeesArray
      allEmployees.append(
        companyEmployees.filter{ $0.type == employeeType }
      )
    }
  }
  
//MARK:- Selector functions
  
  @objc private func handleAdd() {
    //Create the view controller
    let createEmployeeController = CreateEmployeeController()
    createEmployeeController.delegate = self
    //⛑️⛑️⛑️⛑️ Setup the company of the employee+
    createEmployeeController.company = company
    
    //Create a navigation controller and wrap the vc in it
    let navController = UINavigationController(rootViewController: createEmployeeController)
    present(navController, animated: true, completion: nil)
  }
}
