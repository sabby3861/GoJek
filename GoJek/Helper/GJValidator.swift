//
//  GJValidator.swift
//  GoJek
//
//  Created by sanjay on 13/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
struct GJValidator {
  
  static func validate(_ ruleset: GJValidationRuleSet, input: String?, comparisionRule: Bool)-> GJValidationResult
  {
    if comparisionRule == true{
      var result = GJValidationResult()
      result.status = true
      result.message = nil
      let rules = ruleset.rules.filter({ (commonValidationRule) -> Bool in
        commonValidationRule.ruleType == .comparisonRule
      })
      if rules.count == 1{
        result = rules.first!.validate(input: input)
      }
      return result
    }
    return GJValidator.validate(ruleset, input:input, skipComparisionRule:false)
  }
  static func validate(_ ruleset: GJValidationRuleSet,input: String?, skipComparisionRule: Bool = true ) -> GJValidationResult
  {
    for rule in ruleset.rules {
      if skipComparisionRule == true && rule.ruleType == .comparisonRule {
        
      }else{
        let result = rule.validate(input: input)
        if result.status == false{
          return result
        }
      }
    }
    var result = GJValidationResult()
    result.status = true
    result.message = nil
    return result
  }
  
  static func validate(pattern: ValidationPattern, forString input: String?) -> GJValidationResult{
    let rule = GJValidationRulePattern(pattern:pattern)
    return rule.validate(input: input)
  }
  
}



struct GJValidationRulePattern:ValidationRule {
  
  var pattern:String
  var ruleType: ValidationRuleType! = .patternRule
  public init(pattern:String) {
    self.pattern = pattern
  }
  public init(pattern: ValidationPattern) {
    self.init(pattern: pattern.pattern)
  }
  
  func validate(input: Any?) -> GJValidationResult {
    var result = GJValidationResult()
    result.status = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: input)
    result.message = nil
    return result
  }
  
}
