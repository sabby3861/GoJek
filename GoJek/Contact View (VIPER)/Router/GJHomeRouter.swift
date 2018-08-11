//
//  GJHomeRouter.swift
//  FlixBus
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit

class GJContactsRouter: GJContactsRouterProtocol {

  var viewController: GJContactsViewController?
  static func assembleModule(view: GJContactsViewController){
    let presenter = GJContactsPresenter()
    let router = GJContactsRouter()
    let interactor = GJContactsInteractor()
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.output = presenter
    view.presenter = presenter
    router.viewController = view
  }
  
  func showContactDetailView(contactInfo: GJContactInfo) {
    
  }
}
