//
//  FBHomeProtocols.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
/// View Protocols
protocol GJContactsViewProtocol: class
{
  var presenter: GJContactsPresenterProtocol? { get }
  func showContactsInformation(with info: [GJContactInfo])
  func removeActivityView()
}

/// View -> Interactor and View -> Router Communication Protocols
protocol GJContactsPresenterProtocol: class
{
  var view: GJContactsViewProtocol? { get }
  var router: GJContactsRouterProtocol? { get }
  var interactor: GJContactsInteractorProtocol?{get}
  func fetchContactsInformation()
  func sendDataToContactDetailView(info: GJContactInfo)
}


/// Interactor -> Presenter Communication Protocols
protocol GJContactsInteractorProtocol: class
{
  var output: GJContactsOutputProtocol? { get }
  func decodeJSONInformation()
}

protocol GJContactsOutputProtocol: class
{
  func contactInfoDidFetch(contactsInfo: [GJContactInfo])
  func errorOccured()
}

/// Router Protocols and assembling Module
protocol GJContactsRouterProtocol: class
{
  var viewController: GJContactsViewController? { get}
  static func assembleModule(view: GJContactsViewController)
  func showContactDetailView(contactInfo: GJContactInfo)
}
