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

class CreateCompanyController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
  var company: Company? {
    //prefills the edit company nameTextField form with the previous name
    didSet {
      nameTextField.text = company?.name
      guard let founded = company?.founded else { return }
      datePicker.date = founded
      if let imageData = company?.imageData {
       companyImageView.image = UIImage(data: imageData)
       setupCircularImageStyle()
      }
    }
  }
//  var companiesController: CompaniesController?
  //the class CreateCompanyController must conform to the protocol of the class as a delegate
  var delegate: CreateCompanyControllerDelegate?
  
  lazy var companyImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty.png"))
    imageView.isUserInteractionEnabled = true
    imageView.contentMode = .scaleAspectFill
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
    return imageView
  }()
  
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

    setupCancelButton()
    
    setupSaveButtonInNavbar(selector: #selector(handleSave))

    nameTextField.becomeFirstResponder()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = company == nil ? "Create Company" : "Edit Company"
  }
  
  private func setupUI() {
    
    let lightBlueBackgroundView = setupLightBlueBackgroundView(height: 350)
    
    view.addSubview(companyImageView)
    companyImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
    companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    view.addSubview(namelabel)
    
    namelabel.anchor(top: companyImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
   
    view.addSubview(nameTextField)
    nameTextField.anchor(top: namelabel.topAnchor, left: namelabel.rightAnchor, bottom: namelabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0 )
    view.addSubview(datePicker)
    datePicker.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, bottom: lightBlueBackgroundView.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
  }
  
  private func setupCircularImageStyle() {
    companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
    companyImageView.clipsToBounds = true
    companyImageView.layer.borderColor = UIColor.darkBlue.cgColor
    companyImageView.layer.borderWidth = 2
  }
  
  @objc private func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //print(info)
    if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
      companyImageView.image = editedImage
    }else if let originalImage = info[UIImagePickerControllerOriginalImage]  as? UIImage {
      companyImageView.image = originalImage
    }
    setupCircularImageStyle()
    dismiss(animated: true, completion: nil)
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
    if let companyImage = companyImageView.image {
      let imageDate = UIImageJPEGRepresentation(companyImage, 0.8)
      company?.imageData = imageDate
    }
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
    if let companyImage = companyImageView.image {
      let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
      company.setValue( imageData, forKey: "imageData")
    }
   
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
}
