//
//  CreateCompanyController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

//Custom Delegation
protocol CreateCompanyControllerDelegate {
//  Classes conforming to this protocol would need to implement this function
  func didAddCompany(company: Company)
  func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
  
  var company: Company? {
    //prefills the edit company nameTextField form with the previous name
    didSet {
      nameTextField.text = company?.name
      guard let founded = company?.founded else { return }
      datePicker.date = founded
    }
  }
//  var companiesController: CompaniesController?
  //the class CreateCompanyController must conform to the protocol of the class as a delegate
  var delegate: CreateCompanyControllerDelegate?
  
  let namelabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    return label
  }()
  
  let nameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter name"
    return tf
  }()
  
  let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.datePickerMode = .date
    return dp
  }()
  
  //Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .darkBlue
    
    setupUI()

    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    nameTextField.becomeFirstResponder()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = company == nil ? "Create Company" : "Edit Company"
  }
  

  private func setupUI() {
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = .lightBlue
    
    view.addSubview(lightBlueBackgroundView)
   
    lightBlueBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
    
    view.addSubview(namelabel)
    
    namelabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
   
    view.addSubview(nameTextField)
    nameTextField.anchor(top: namelabel.topAnchor, left: namelabel.rightAnchor, bottom: namelabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0 )
    view.addSubview(datePicker)
    datePicker.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, bottom: lightBlueBackgroundView.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
  }
  
  @objc private func handleSave() {
    if company == nil {
      createCompany()
    }else{
      saveCompanyChanges()
    }
  }
  
  //Save company edits
  private func saveCompanyChanges(){
    let context = CoreDataManager.shared.persistentContainer.viewContext
    company?.name = nameTextField.text
    company?.founded = datePicker.date
    do {
      try context.save()
      dismiss(animated: true) {
        self.delegate?.didEditCompany(company: self.company!)
      }
    } catch let err {
      print("Unable to edit company error", err)
    }
  }
  
  private func createCompany() {
    nameTextField.resignFirstResponder()
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
    
    company.setValue(nameTextField.text, forKey: "name")
    company.setValue(datePicker.date, forKey: "founded")
    
    //2.   Perform the save
    
    do{
      try context.save()
      //      success
      dismiss(animated: true) {
        self.delegate?.didAddCompany(company: company as! Company)
      }
    }catch let saveErr{
      print("Failed to save company", saveErr)
    }
  }
  
  @objc private func handleCancel() {
    dismiss(animated: true, completion: nil)
  }

}
