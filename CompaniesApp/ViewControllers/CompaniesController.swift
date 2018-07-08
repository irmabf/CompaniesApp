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
  
  let cellId = "cellId"
  
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
  //  Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCompanies()
    view.backgroundColor = .white
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupNavigationItems()
    setupTableViewStyle()
  }
  
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
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, indexPath) in
      let company = self.companies[indexPath.row]
      print("Attempting to edit company:", company.name ?? "")
    }
     return [deleteAction, editAction]
  }
  
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
  
}

















