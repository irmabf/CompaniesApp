//
//  UIViewController+Navigation.swift
//  CompaniesApp
//
//  Created by Irma Blanco on 04/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension UIViewController {
  func setupPlusButtonInNavBar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
  }
  
  func setupSaveButtonInNavbar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
  }
  func setupCancelButton() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
  }
  @objc private func handleCancelModal() {
    dismiss(animated: true, completion: nil)
  }
  func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = .lightBlue
    
    view.addSubview(lightBlueBackgroundView)
    
    lightBlueBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
    
    return lightBlueBackgroundView
  }
  
}
