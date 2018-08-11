//
//  FBHomePresenter.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class GJContactsPresenter: GJContactsPresenterProtocol {
  var view: GJContactsViewProtocol?
  var router: GJContactsRouterProtocol?
  var interactor: GJContactsInteractorProtocol?
  
  func fetchContactsInformation(){
    interactor?.decodeJSONInformation()
  }
  
  func sendDataToContactDetailView(info: GJContactInfo){
    router?.showContactDetailView(contactInfo: info)
  }
}


// MARK: - Presenter to view communcation
extension GJContactsPresenter: GJContactsOutputProtocol{
  
  func contactInfoDidFetch(busInfo: [GJContactInfo]){
    view?.showContactsInformation(with: busInfo)
  }
  func errorOccured(){
    
  }
}
