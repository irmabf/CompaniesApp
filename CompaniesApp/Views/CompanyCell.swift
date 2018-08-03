//
//  CompanyCell.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 03/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
  
  var company: Company? {
    didSet {
      nameFoundedDateLabel.text = company?.name
      
      if let imageData = company?.imageData {
        companyImageView.image = UIImage(data: imageData)
      }
      
      if let name = company?.name, let founded = company?.founded {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let foundedDateString = dateFormatter.string(from: founded)
        let dateString = "\(name) - Founded: \(foundedDateString)"
        nameFoundedDateLabel.text = dateString
      } else {
        nameFoundedDateLabel.text = company?.name
      }
    }
  }
  
  // you cannot declare another image view using "imageView"
  let companyImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
    imageView.contentMode = .scaleAspectFill

    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    imageView.layer.borderColor = UIColor.darkBlue.cgColor
    imageView.layer.borderWidth = 1
    return imageView
  }()
  
  let nameFoundedDateLabel: UILabel = {
    let label = UILabel()
    label.text = "COMPANY NAME"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .white

    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.tealColor
    
    addSubview(companyImageView)
    companyImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    addSubview(nameFoundedDateLabel)
    nameFoundedDateLabel.anchor(top: topAnchor, left: companyImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

