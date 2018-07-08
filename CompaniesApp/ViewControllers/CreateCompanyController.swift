//
//  CreateCompanyController.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 08/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
  
  let namelabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.backgroundColor = .red
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
   
    
    navigationItem.title = "Create Company"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    view.backgroundColor = .darkBlue
  }
  


  
  @objc fileprivate func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  

}
