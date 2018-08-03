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
}












