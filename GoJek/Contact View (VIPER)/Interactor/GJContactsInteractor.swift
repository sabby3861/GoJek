//
//  FBHomeInteractor.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
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
        //self.output?.busInfoDidFetch(busInfo: data.timetable)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        //FBAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
      }
    }
  }
  
}
