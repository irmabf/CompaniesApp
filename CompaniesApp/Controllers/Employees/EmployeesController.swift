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
 
  var company: Company?
  
  var employees = [Employee]()
  
  let cellId = "cellId"
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = company?.name
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //Pull the employee from the employees array with the indexpath.row as the index of the array
    let employee = employees[indexPath.row]
    cell.textLabel?.text = employee.name
    
    if let birthday = employee.employeeInformation?.birthday {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM dd, yyyy"
      
      cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
    }
    
    //        if let taxId = employee.employeeInformation?.taxId {
    //            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
    //        }
    
    cell.backgroundColor = UIColor.tealColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    
    return cell
  }
  
  private func fetchEmployees() {
//    company?.employees
    
    guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
    
//    self.employees = company?.employees?.allObjects as! [Employee]
    
    self.employees = companyEmployees
    
//    let context = CoreDataManager.shared.persistentContainer.viewContext
//
//    let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//    do {
//      let employees = try context.fetch(request)
//      //‼️ Important or we will get initial value of 0 employees in the array
//      self.employees = employees
//
//      //employees.forEach{print("Employee name:", $0.name ?? "")}
//    } catch let err {
//      print("Failed to fetch employees:", err)
//    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchEmployees()
    
    tableView.backgroundColor = .darkBlue
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupPlusButtonInNavBar(selector: #selector(handleAdd))
    
  }
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
