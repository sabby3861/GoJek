//
//  FBHomeInteractor.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GJContactsInteractor: GJContactsInteractorProtocol {
  var output: GJContactsOutputProtocol?
  func decodeJSONInformation(){
    guard let data = fetchFromStorage() else {
      return
    }
    self.output?.contactInfoDidFetch(contactsInfo: data)
  }
  
  func startDownloadingContacts() {
    let parser = GJJSONParser()
    let service = GJContactService()
    parser.request(resource: service.service) { [unowned self] result in
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
      let appDelegate = getAppDelegate()
      let managedObjectContext = appDelegate.persistentContainer.viewContext
      try managedObjectContext.save()
    }
    catch let error {
      print(error)
    }
  }
  
  func fetchFromStorage() -> [GJContactInfo]? {
    let delegate = getAppDelegate()
    let managedObjectContext = delegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<GJContactInfo>(entityName: GJCoreData.name.rawValue)
    do {
      let contacts = try managedObjectContext.fetch(fetchRequest)
      return contacts
    } catch let error {
      print(error)
      return nil
    }
  }
  
  func getAppDelegate() -> AppDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate
  }
}
