//
//  GJTextField.swift
//  GoJek
//
//  Created by sanjay on 13/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

enum GJFieldType{
  case email
  case password
  case telephone
  case userName
  case none
}

public class GJTextField: UITextField {
  
  var type: GJFieldType = .none{
    didSet{
      if type == .password{
        self.isSecureTextEntry = true
      }else{
        self.isSecureTextEntry = false
      }
    }
  }
  
  var ruleSet: GJValidationRuleSet?
  var errorMessage: ((GJTextField, String) ->Void)?
  var updateValue: ((GJTextField, String) ->Void)?
  var isMandatory:Bool = false
  var isValid:Bool = false{
    didSet{
      updateView()
    }
  }
  var leftImage:String?{
    didSet{
      if leftImage != nil {
        let arrow = UIImageView(image: UIImage(named: leftImage!))
        leftView = arrow
        bringSubview(toFront: leftView!)
        leftViewMode = .always
      }else{
        leftView = nil
        leftViewMode = .never
      }
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    background = #imageLiteral(resourceName: "textfield")
    delegate = self
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    delegate = self
    background = #imageLiteral(resourceName: "textfield")
  }
  
  public override func textRect(forBounds bounds: CGRect) -> CGRect {
    let x:CGFloat = (leftView != nil) ? 40 : 10
    return CGRect(x: x, y: bounds.origin.y, width: bounds.width - x, height: bounds.height)
  }
  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let x:CGFloat = (leftView != nil) ? 40 : 10
    return CGRect(x: x, y: bounds.origin.y, width: bounds.width - x, height: bounds.height)
  }
  
  public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.leftViewRect(forBounds: bounds)
    rect.origin.x = 10
    return rect
  }
  
  public func updateView(){
    if isValid == false{
      self.layer.borderColor = UIColor.red.cgColor
      self.layer.borderWidth = 1.0
    }else{
      self.layer.borderWidth = 0.0
    }
    
  }
  
}
