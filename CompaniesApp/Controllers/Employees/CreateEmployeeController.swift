//
//  CreateEmployeeController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 04/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
  // Classes conforming to this protocol would need to implemente these functions
  func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
  
  /*Whenever we are presenting the create employee controller
   we need to set the company inside the class
   
   We set the company as an optional so that it starts as nil
   at the begining
   
   Then we go to EmployeesController ⛑️⛑️⛑️
   */
  var company: Company?
  
  // the class CreateEmployeeController must conform to the protocol of the class as a delegate
  var delegate: CreateEmployeeControllerDelegate?
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    return label
  }()
  
  let nameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter name"
    return tf
  }()
  
  let birthdayLabel: UILabel = {
    let label = UILabel()
    label.text = "Birthday"
    return label
  }()
  
  let birthdayTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "MM/dd/YYYY"
    return tf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //nameTextField.becomeFirstResponder()
    navigationItem.title = "Create Employee"
    setupCancelButton()
    view.backgroundColor = .darkBlue
    setupUI()
    
    setupSaveButtonInNavbar(selector: #selector(handleSave))
  }
  
  private func showError(title: String, message: String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
    present(alertController, animated: true, completion: nil)
    return
  }

  let employeeTypeSegmentedControl: UISegmentedControl = {
    let types = ["Executive", "Senior Management", "Staff"]
    let sc = UISegmentedControl(items: types)
    sc.selectedSegmentIndex = 0
    sc.tintColor = .darkBlue
    return sc
  }()
  
  private func setupUI() {
    
    _ = setupLightBlueBackgroundView(height: 150)
    
    view.addSubview(nameLabel)
    
    nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
    
    view.addSubview(nameTextField)
    nameTextField.anchor(top: nameLabel.topAnchor, left: nameLabel.rightAnchor, bottom: nameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0 )
    
    view.addSubview(birthdayLabel)
    birthdayLabel.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
    
    view.addSubview(birthdayTextField)
    birthdayTextField.anchor(top: birthdayLabel.topAnchor, left: birthdayLabel.rightAnchor, bottom: birthdayLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(employeeTypeSegmentedControl)
    employeeTypeSegmentedControl.anchor(top: birthdayLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 34)

  }
  
  @objc private func handleSave(){
    guard let employeeName = nameTextField.text else { return }
    //where do we get company from?
    guard let company = company else { return }
    
    //turn birthday into a date object
    
    guard let birthdayText = birthdayTextField.text else { return }
    
    //lets perform the validation step here
    if birthdayText.isEmpty {
      showError(title:"Empty Birthday" , message: "You have not entered a birthday." )
      return
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    
    guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
      showError(title: "Bad date", message: "Birthday date entered not valid")
      return
    }
    
    guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
    
    print(employeeType)

    let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, birthday: birthdayDate, company: company)
    
    if let error = tuple.1 {
      //in production this is where we would present an error modal of some kind, perhaps
      //an UIAlertController to show our error message
      print(error)
    }else{
      // on creation successs
      dismiss(animated: true) {
        //we´ll call the delegate
        self.delegate?.didAddEmployee(employee: tuple.0!)
      }
      dismiss(animated: true, completion: nil)
    }
  }
  
}





















