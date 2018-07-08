//
//  ViewController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
//  We must implement the didAddCompany method because to conform to the CreateCompanyControllerDelegate
  func didAddCompany(company: Company) {
    //    let tesla = Company(name: "Tesla", founded: Date())
    //    1. Modify array
    companies.append(company)
    //    2. Insert a new indexPath into tableView
    let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .fade)
  }
  
  var companies = [Company]()
//  var companies = [
//    Company(name: "Apple", founded: Date()),
//    Company(name: "Google", founded: Date()),
//    Company(name: "Facebook", founded: Date())
//  ]
  
//  func addCompany(company: Company) {
////    let tesla = Company(name: "Tesla", founded: Date())
////    1. Modify array
//    companies.append(company)
////    2. Insert a new indexPath into tableView
//    let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
//    tableView.insertRows(at: [newIndexPath], with: .fade)
//  }
  
  let cellId = "cellId"
  
  private func fetchCompanies(){
    let persistentContainer = NSPersistentContainer(name: "CompaniesAppModels")
    persistentContainer.loadPersistentStores { (storeDescription, err) in
      if let err = err {
        fatalError("Loading of store failed: \(err)")
      }
    }
    
    let context = persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do{
      let companies = try context.fetch(fetchRequest)
      companies.forEach { (company) in
        print(company.name ?? "")
      }
    }catch let fetchErr{
      print("Failed to fetch err:", fetchErr)
    }
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCompanies()
    
//    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "TEST ADD", style: .plain, target: self, action: #selector(addCompany))
    
    view.backgroundColor = .white
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupNavigationItems()
    
    setupTableViewStyle()
  }
  
  //  Custom functions
  
  @objc func handleAddCompany() {
    let createCompanyController = CreateCompanyController()
    let navController = CustomNavigationController(rootViewController: createCompanyController)
    
    createCompanyController.delegate = self
    
    present(navController, animated: true, completion: nil)
  }
  
  //  Custom functions for styles
  fileprivate func setupTableViewStyle() {
    //    tableView.separatorStyle = .none
    //    This code removes the separator from the part of the tableView without cells
    tableView.tableFooterView = UIView() // blank UIView
    tableView.backgroundColor =  .darkBlue
    tableView.separatorColor = .white
  }
  
  fileprivate func setupNavigationItems() {
    navigationItem.title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
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

















