//
//  CoreDataManager.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import CoreData

struct CoreDataManager {
  
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer = {
    // 1.   Initialization of our Core Data Stack
    let container = NSPersistentContainer(name: "CompaniesAppModels")
    container.loadPersistentStores { (storeDescription, err) in
      if let err = err {
        fatalError("Loading of store failed: \(err)")
      }
    }
    return container
  }()
  
  func fetchCompanies() -> [Company] {
    let context = persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do {
      let companies = try context.fetch(fetchRequest)
      
      return companies
      
    } catch let fetchErr {
      print("Failed to fetch companies:", fetchErr)
      return []
    }
  }
  //create an employee
  func createEmployee(employeeName: String, birthday: Date, company: Company) -> (Employee?, Error?) {
    let context = persistentContainer.viewContext
    
    //create an employee
    let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
    //Setup the employee´s company to the company that
    //we are passing in
    employee.company = company
    
    // lets check company is setup correctly
    //        let company = Company(context: context)
    //        company.employees
    //
    //        employee.company
    
    employee.setValue(employeeName, forKey: "name")
    
    let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
    
    
    //setup the birthday in employeeInformation to the incoming parameter from abobe
    employeeInformation.birthday = birthday
    
    
    
    employee.employeeInformation = employeeInformation
    
    do {
      try context.save()
      // save succeeds
      return (employee, nil)
    } catch let err {
      print("Failed to create employee:", err)
      return (nil, err)
    }
    
  }
}












