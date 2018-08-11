//
//  GJContactsViewController.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class GJContactsViewController: UIViewController, GJContactsViewProtocol {
  var presenter: GJContactsPresenterProtocol?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.formatPayload(with: .RequestMethodGET)
    self.presenter?.fetchContactsInformation()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func showContactsInformation(with info: [GJContactInfo]){
    print("Contacts info fetched is \(info)")
  }

  func removeActivityView() {
    
  }
}

extension UIViewController: PayLoadFormat{}
