//
//  ViewController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController{
    
  var companies = [Company]() // empty array
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.companies = CoreDataManager.shared.fetchCompanies()
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    
    view.backgroundColor = .white
    
    navigationItem.title = "Companies"
    
    tableView.backgroundColor = UIColor.darkBlue
    //        tableView.separatorStyle = .none
    tableView.separatorColor = .white
    tableView.tableFooterView = UIView() // blank UIView
    
    tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
    
    setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
  }
  
  @objc private func handleReset() {
    print("Attempting to delete all core data objects")
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    //        companies.forEach { (company) in
    //            context.delete(company)
    //        }
    
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do {
      try context.execute(batchDeleteRequest)
      
      // upon deletion from core data succeeded
      
      var indexPathsToRemove = [IndexPath]()
      
      for (index, _) in companies.enumerated() {
        let indexPath = IndexPath(row: index, section: 0)
        indexPathsToRemove.append(indexPath)
      }
      companies.removeAll()
      tableView.deleteRows(at: indexPathsToRemove, with: .left)
      

      
    } catch let delErr {
      print("Failed to delete objects from Core Data:", delErr)
    }
    
  }
  
  @objc func handleAddCompany() {
    print("Adding company..")
    
    let createCompanyController = CreateCompanyController()
    //        createCompanyController.view.backgroundColor = .green
    
    let navController = CustomNavigationController(rootViewController: createCompanyController)
    
    createCompanyController.delegate = self
    
    present(navController, animated: true, completion: nil)
    
  }

}












