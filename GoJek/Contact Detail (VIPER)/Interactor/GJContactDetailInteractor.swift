//
//  GJContactDetailInteractor.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class GJContactDetailInteractor: GJContactDeailInteractorProtocol {
  var output: GJContactDeailOutputProtocol?
  
  func decodeJSONInformation(contactId: Int32) {
    let parser = GJJSONParser()
    let urlString = "\(baseUrl)/" + "contacts/" + "\(contactId)" + ".json"
    GJDetailUrl.url =  urlString
    let service = GJContactDetailService()
    
    parser.request(resource: service.service) { [unowned self] result in
      switch result {
      case .success(let data):
        print("Data is \(data)")
        self.output?.contactDetailDidFetch(contactsInfo: data)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        self.output?.errorOccured()
        DispatchQueue.main.async {
          GJAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
        }
      }
    }
  }
  
  func sendJSONInformation(contactId: Int){
    let parser = GJJSONParser()
    let urlString = "\(baseUrl)/" + "contacts/" + "\(contactId)" + ".json"
    GJDetailUrl.url =  urlString
    let service = GJContactUpdateService()
    parser.request(resource: service.service) { [unowned self] result in
      switch result {
      case .success(let data):
        print("Data is \(data)")
        self.output?.errorOccured()
        GJAlertViewController.showAlert(withTitle: "GoJek", message:  "Contact informations has been updated")
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        self.output?.errorOccured()
        DispatchQueue.main.async {
          GJAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
        }
      }
    }
  }
  
}
