//
//  GJValidations.swift
//  GoJek
//
//  Created by sanjay on 13/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation

struct GJValidationRuleSet{
  var rules = [CommonValidationRule]()
  init<R:ValidationRule>(rules:[R]){
    self.rules = rules.map(CommonValidationRule.init)
  }
  mutating func add<R:ValidationRule>(rule:R)
  {
    let commonRule = CommonValidationRule(rule: rule)
    self.rules.append(commonRule)
  }
    mutating func removeAllRules()  {
    self.rules.removeAll()
  }
}




struct GJValidationResult {
  var message:String?
  var status:Bool = false
  var validAmount:NSDecimalNumber?
}


protocol ValidationRule {
  func validate(input:Any?) -> GJValidationResult
  var ruleType:ValidationRuleType! {get}
}

struct CommonValidationRule:ValidationRule {
  var ruleType:ValidationRuleType! = .otherRule
  private let validateInput: (Any?)-> GJValidationResult
  init<R: ValidationRule>(rule:R) {
    ruleType = rule.ruleType
    validateInput = rule.validate
  }
  internal func validate(input: Any?) -> GJValidationResult {
    return validateInput(input)
  }
}

enum ValidationRuleType{
  case patternRule
  case lengthRule
  case comparisonRule
  case otherRule
}


protocol ValidationPattern {
  var pattern:String { get }
}
enum GJAlphabetsValidation: String, ValidationPattern
{
  case alphabetsOnly
  case alphaNumeric
  public var pattern: String {
    switch self {
    case .alphabetsOnly: return "^[a-zA-Z]*$"
    case .alphaNumeric: return "\\A\\w{5,18}\\z"
    }
  }
}


enum GJNumericValidation: String, ValidationPattern {
  case phoneNumber
  case phoneNumberWithSpecial
  public var pattern:String{
    switch self{
    case .phoneNumberWithSpecial:
      return "^(?:(?:\\+|00)(33|41)|0)\\s*[1-9](?:[\\s.-]*\\d{2}){4}$"
    case .phoneNumber:
      return "^[0-9+]*$"
    }
  }
}


enum GJEmailValidation: String,ValidationPattern
{
  case email
  public var pattern: String {
    switch self {
    case .email: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    }
  }
  
}

