//
//  FBHomeInteractor.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit

class GJContactsInteractor: GJContactsInteractorProtocol {
  var output: GJContactsOutputProtocol?
  
  func decodeJSONInformation(){
    let parser = GJJSONParser()
    let service = GJContactService()
    parser.request(resource: service.service) { [unowned self] result in
      //print("Result Is \(result)")
      switch result {
      case .success(let data):
        print("Data is \(data)")
        self.saveToCoreData()
        self.output?.contactInfoDidFetch(contactsInfo: data)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        DispatchQueue.main.async {
          GJAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
        }
      }
    }
  }
  
  func saveToCoreData() {
    do {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedObjectContext = appDelegate.persistentContainer.viewContext
      try managedObjectContext.save()
    }
    catch let error {
      print(error)
    }
  }
}
