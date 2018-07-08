//
//  CreateCompanyController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

//Custom Delegation
protocol CreateCompanyControllerDelegate {
//  Classes conforming to this protocol would need to implement this function
  func didAddCompany(company: Company)
}

class CreateCompanyController: UIViewController {
//  var companiesController: CompaniesController?
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .darkBlue
    
    setupUI()
    
    navigationItem.title = "Create Company"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    
  }
  
  private func setupUI() {
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = .lightBlue
    
    view.addSubview(lightBlueBackgroundView)
   
    lightBlueBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    
    view.addSubview(namelabel)
    
    namelabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
   
    view.addSubview(nameTextField)
    nameTextField.anchor(top: namelabel.topAnchor, left: namelabel.rightAnchor, bottom: namelabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0 )
  }
  
  @objc private func handleSave() {
    
    dismiss(animated: true) {
      guard let name = self.nameTextField.text else { return  }
      
      let company = Company(name: name, founded: Date())
      self.delegate?.didAddCompany(company: company)
    }
  }
  
  @objc private func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  

}
