//
//  GJContactDetailRouter.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class GJContactDetailRouter: GJContactDeailRouterProtocol {
  
  var viewController: GJContactDetailViewController?
  static func assembleModule(view: GJContactDetailViewController, contact: GJContactInfo){
    let presenter = GJContactDetailPresenter()
    let router = GJContactDetailRouter()
    let interactor = GJContactDetailInteractor()
    view.contact = contact
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.output = presenter
    view.presenter = presenter
    router.viewController = view
  }
  
  func showContactDetailView(contactInfo: GJContactInfo) {
    
  }
  
  func showCameraOrPhotoLibrary(type: GJCameraType) {
    let picker = UIImagePickerController()
    if type == GJCameraType.camera{
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = viewController
        viewController?.present(picker,animated: true,completion: nil)
      } else {
        showErrorMessage(error: "This device does not support camera")
      }
    }else{
      picker.allowsEditing = false
      picker.sourceType = .photoLibrary
      picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
      picker.modalPresentationStyle = .popover
      picker.delegate = viewController
      viewController?.present(picker, animated: true, completion: nil)
    }
  }
  
  func showErrorMessage(error: String) {
    DispatchQueue.main.async {
      GJAlertViewController.showAlert(withTitle: "Error", message: error)
    }
  }
  
  
  // A wrapper function to indicate whether or not a text message can be sent from the user's device
  func canSendText() -> Bool {
    return MFMessageComposeViewController.canSendText()
  }
  // Send a message
  func sendMessage(recipient: String) {
    if canSendText(){
      let messageVC = MFMessageComposeViewController()
      messageVC.body = "GoJek Welcomes You"
      messageVC.recipients = [recipient]
      messageVC.messageComposeDelegate = viewController
      viewController?.present(messageVC, animated: true, completion: nil)
    }else{
      showErrorMessage(error: "This device does not support sms service")
    }
  }
  
  func startTheCall(to number: String) {
    number.makeCall()
  }
}
