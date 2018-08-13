//
//  GJTableView.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay chauhan. All rights reserved.
//

import UIKit

class GJTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  let defaultInset = UIEdgeInsetsMake(0, 0, 0, 0)
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    resetSeparatorInset()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    resetSeparatorInset()
  }
  func resetSeparatorInset() {
    self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func addCellIdentifiers(_ identifiers:[String]) {
    for identifier in identifiers {
      let nib = UINib.init(nibName: identifier, bundle: nil)
      register(nib, forCellReuseIdentifier: identifier)
    }
  }
  func addHeaderIdentifiers(_ identifiers:[String])  {
    for identifier in identifiers {
      let nib = UINib.init(nibName: identifier, bundle: nil)
      register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
  }
  
  func keyboardWillShow(notification:NSNotification)  {
    adjustingHeight(show: true, notification: notification)
  }
  
  func adjustingHeight(show:Bool, notification:NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      
      let changeInHeight = (keyboardSize.height + 40) * (show ? 1 : -1)
      let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , changeInHeight)
      self.contentInset = contentInsets
      self.scrollIndicatorInsets = self.contentInset
    }
  }
  
  func keyboardWillHide(notification:NSNotification)  {
    self.contentInset = defaultInset
    self.scrollIndicatorInsets = .zero
  }
}
