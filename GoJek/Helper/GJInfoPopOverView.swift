//
//  GJInfoPopOverView.swift
//  GoJek
//
//  Created by sanjay on 13/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit
import Foundation

class GJInfoPopOverView: UIViewController{
  static let sharedInstance = GJInfoPopOverView()
  var isAlertShowing:Bool = false
  
  var messagelbl:UILabel?
  var messagge:String?
  override func viewDidLoad() {
    messagelbl = UILabel()
    messagelbl?.text = messagge
    messagelbl!.textAlignment = .center
    messagelbl?.numberOfLines = 0
    messagelbl?.lineBreakMode = .byWordWrapping
    messagelbl?.sizeToFit()
    messagelbl?.backgroundColor = .gjColor
    messagelbl?.layer.cornerRadius = 20
    
    messagelbl?.layer.masksToBounds = true
    view.addSubview(messagelbl!)
    view.backgroundColor = .clear

    messagelbl?.translatesAutoresizingMaskIntoConstraints = false
    messagelbl?.widthAnchor.constraint(equalToConstant: 250).isActive = true
    messagelbl?.heightAnchor.constraint(equalToConstant: 100).isActive = true
    messagelbl?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    messagelbl?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    //Add shadow to the label
    messagelbl?.layer.shadowPath = UIBezierPath(rect: (messagelbl?.bounds)!).cgPath
    messagelbl?.layer.shouldRasterize = true
    messagelbl?.layer.shadowColor = UIColor.black.cgColor
    
    messagelbl?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    messagelbl?.layer.shadowOpacity = 0.2
    messagelbl?.layer.shadowRadius = 3

  }
  @objc func dismissPopOverController() {
    
    self.isAlertShowing = false
    self.dismiss(animated: true) {
      
    }
  }
  func setupDismiss(){
    
    self.perform(#selector(dismissPopOverController), with: nil, afterDelay: 1.5)
  }
  //TODO:// Need to rewrite this part
  func getHeight(msg:String?, width:CGFloat) ->CGFloat {
    var label:UILabel? = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label!.text = msg
    label!.textAlignment = .center
    label?.numberOfLines = 0
    label?.lineBreakMode = .byWordWrapping
    label?.sizeToFit()
    let height = label!.frame.height
    label = nil
    return height
  }
  
}
extension GJInfoPopOverView{
  
  static func presentPopover(fromViewController vc: UIViewController, sourceView: UIView, message:String, arrowDirection: UIPopoverArrowDirection?  = .any) {
    
    let popOverVC = GJInfoPopOverView.sharedInstance
    popOverVC.messagge = message
    if(popOverVC.isAlertShowing)
    {
      self.cancelPreviousPerformRequests(withTarget: popOverVC)
      popOverVC.messagelbl?.text = message
      popOverVC.setupDismiss()
      return
    }
    popOverVC.modalPresentationStyle = .overCurrentContext
    popOverVC.view.backgroundColor = .clear
    popOverVC.messagelbl?.text = message
    var height = popOverVC.getHeight(msg: message, width: sourceView.frame.size.width)
    height = height + 15
    popOverVC.preferredContentSize = CGSize.init(width: sourceView.frame.size.width, height: height)
    popOverVC.isAlertShowing = true
    vc.present(popOverVC, animated: true)
    popOverVC.setupDismiss()
  }
}


extension UIColor{
  class var gjColor: UIColor{
    return UIColor(red: 55/255, green: 142/255, blue: 41/255, alpha: 1.0)
  }
}
