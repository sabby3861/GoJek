//
//  GJContactDetailPresenter.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class GJContactDetailPresenter: GJContactDeailPresenterProtocol {
  var view: GJContactDeailViewProtocol?
  var router: GJContactDeailRouterProtocol?
  var interactor: GJContactDeailInteractorProtocol?
  
  func fetchContactsDetail(id: Int32) {
    interactor?.decodeJSONInformation(contactId: id)
  }
  
  func sendDataToContactDetailView() {
    interactor?.sendJSONInformation()
  }
  
  
}


// MARK: - Presenter to view communcation
extension GJContactDetailPresenter: GJContactDeailOutputProtocol{
  
  func contactDetailDidFetch(contactsInfo: GJContactDetail){
    view?.showContactsInformation(with: contactsInfo)
  }
  func errorOccured(){
    
  }
}
