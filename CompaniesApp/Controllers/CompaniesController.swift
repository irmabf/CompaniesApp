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
  
  func didEditCompany(company: Company) {
    //Get the index of the company in the companies array
    let row = companies.index(of: company)
    let reloadIndexPath = IndexPath(row: row!, section: 0)
    //update my tableview
    tableView.reloadRows(at: [reloadIndexPath], with: .middle)
  }
  
  var companies = [Company]()
  
  let cellId = "cellId"
  
  //  Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCompanies()
    view.backgroundColor = .white
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupNavigationItems()
    setupTableViewStyle()
  }
  //Overrides
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
      let company = self.companies[indexPath.row]
      print("Attempting to delete company:", company.name ?? "")
      
// 1 -    remove the company from our tableview
      
      //1.1- Remove the company from the index
      self.companies.remove(at: indexPath.row)
      //1.2- Remove the row from the table
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
// 2 -     delete the company from Core Data
      let context = CoreDataManager.shared.persistentContainer.viewContext
      //2.1 - Delete
      context.delete(company)
      //2.2 - Persist the deletion
      do{
        try context.save()
      }catch let saveErr{
        print("Failed to save deletion with error:", saveErr)
      }
    }
    deleteAction.backgroundColor = .lightRed
    
    let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
    editAction.backgroundColor = .darkBlue
     return [deleteAction, editAction]
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    let company = companies[indexPath.row]
    
    cell.backgroundColor = .tealColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    if let name = company.name, let founded = company.founded {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM dd, yyyy"
      let foundedDateString = dateFormatter.string(from: founded)
      let dateString = "\(name) - Founded: \(foundedDateString)"
      cell.textLabel?.text = dateString
    }else{
      cell.textLabel?.text = company.name
    }
    //cell.textLabel?.text = "\(company.name) - Founded: \(company.founded)"
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
  
  //  Custom functions

  
  private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
    let editCompanyController = CreateCompanyController()
    editCompanyController.delegate = self
    //We pass the indexpath that we are swiping as the indexpath for the company title
    editCompanyController.company = companies[indexPath.row]
    let navController = CustomNavigationController(rootViewController: editCompanyController)
    present(navController, animated: true, completion: nil)
  }
  private func fetchCompanies(){
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do{
      let companies = try context.fetch(fetchRequest)
      
      companies.forEach ({ (company) in
        //        print(company.name ?? "")
        self.companies = companies
        tableView.reloadData()
      })
    }catch let fetchErr{
      print("Failed to fetch err:", fetchErr)
    }
  }
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
  
}














