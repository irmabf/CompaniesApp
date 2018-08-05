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
  
  // the class CreateEmployeeController must conform to the protocol of the class as a delegate
  var delegate: CreateEmployeeControllerDelegate?
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //nameTextField.becomeFirstResponder()
    navigationItem.title = "Create Employee"
    setupCancelButton()
    view.backgroundColor = .darkBlue
    setupUI()
    
    setupSaveButtonInNavbar(selector: #selector(handleSave))
  }
  
  private func setupUI() {
    
    _ = setupLightBlueBackgroundView(height: 50)
    
    view.addSubview(namelabel)
    
    namelabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
    
    view.addSubview(nameTextField)
    nameTextField.anchor(top: namelabel.topAnchor, left: namelabel.rightAnchor, bottom: namelabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0 )

  }
  
  @objc private func handleSave(){
    guard let employeeName = nameTextField.text else { return }
    
    let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName)
    
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





















