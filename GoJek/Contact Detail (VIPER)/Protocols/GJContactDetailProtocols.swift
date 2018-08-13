//
//  GJContactDetailProtocols.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
protocol GJContactDeailViewProtocol: class
{
  var presenter: GJContactDeailPresenterProtocol? { get }
  var contact: GJContactInfo? {get}
  func showContactsInformation(with info: GJContactDetail)
  func removeActivityView()
}

/// View -> Interactor and View -> Router Communication Protocols
protocol GJContactDeailPresenterProtocol: class
{
  var view: GJContactDeailViewProtocol? { get }
  var router: GJContactDeailRouterProtocol? { get }
  var interactor: GJContactDeailInteractorProtocol?{get}
  func fetchContactsDetail(id: Int32)
  func sendDataToContactDetailView()
}


/// Interactor -> Presenter Communication Protocols
protocol GJContactDeailInteractorProtocol: class
{
  var output: GJContactDeailOutputProtocol? { get }
  func decodeJSONInformation(contactId: Int32)
  func sendJSONInformation()
}

protocol GJContactDeailOutputProtocol: class
{
  func contactDetailDidFetch(contactsInfo: GJContactDetail)
  func errorOccured()
}

/// Router Protocols and assembling Module
protocol GJContactDeailRouterProtocol: class
{
  var viewController: GJContactDetailViewController? { get}
  static func assembleModule(view: GJContactDetailViewController, contact: GJContactInfo)
  func showContactDetailView(contactInfo: GJContactInfo)
}
