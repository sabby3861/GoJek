//
//  GJTextFieldDelegate.swift
//  GoJek
//
//  Created by sanjay on 13/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

protocol GJTextFieldDelegate:UITextFieldDelegate  {
  
  func textFieldValueChanged(_ textfield: GJTextField)
}

extension GJTextField: GJTextFieldDelegate{
  
  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true
  }
  public func textFieldDidEndEditing(_ textField: UITextField) {
    let wsTextField = textField as! GJTextField
    updateValue?(wsTextField, textField.text!)
    _ = validateTextField(textField)
  }
  /*public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if shouldEndEditing == false{
      shouldEndEditing = true
      return true
    }
    shouldEndEditing = false
    return validateTextField(textField)
  }*/
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  private func validateTextField(_ textField:UITextField) -> Bool{
    
    let wsTextField = textField as! GJTextField
    var result = GJValidationResult()
    result.status = true
    
    if wsTextField.isMandatory == true && textField.text == ""{
      wsTextField.isValid = false
      result.status = false
      return true
    }
    
    switch wsTextField.type {
    case .email:
      result = GJValidator.validate(pattern: GJEmailValidation.email, forString: textField.text)
      if result.status == false {
        result.message = "Invalid E-mail Address"
      }
    case .telephone:
      result = GJValidator.validate(pattern: GJNumericValidation.phoneNumberWithSpecial, forString: textField.text)
      if result.status == false {
        result.message = "Phone number format is wrong"
      }
    case .userName:
      result = GJValidator.validate(pattern: GJAlphabetsValidation.alphaNumeric, forString: textField.text)
      if result.status == false {
        result.message = "Username should be atleast 5 characters in length and contain only alphanumerics"
      }
    default:
      break
    }
    if result.message != nil {
      errorMessage?(wsTextField, result.message!)
    }
    wsTextField.isValid = result.status
    return true
  }
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    
    if range.length > 0 {
      return true
    }
    let wsTextField = textField as! GJTextField
    
    let status:Bool = validate(byFieldType: wsTextField.type, fullString: string)
    guard status else {
      errorMessage?(wsTextField, string + " Not allowed")
      return false
    }
    guard let _ = wsTextField.ruleSet else {
      return true
    }
    return true
  }
  func validate(byFieldType type: GJFieldType, fullString:String) -> Bool {
    
    var result = GJValidationResult()
    switch type {
    case .text:
      result = GJValidator.validate(pattern: GJAlphabetsValidation.alphabetsOnly, forString: fullString)
    case .telephone:
      result = GJValidator.validate(pattern: GJNumericValidation.phoneNumber, forString: fullString)
    default:
      result.status = true
    }
    return result.status
    
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    
  }
  
  func textFieldValueChanged(_ WSTextField: GJTextField) {
    
  }
}
