//
//  GoJekTests.swift
//  GoJekTests
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import XCTest

@testable import GoJek

class GoJekTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testContacts() {
    
    let parser = GJJSONParser()
    let service = GJContactService()
    parser.request(resource: service.service) { result in
      switch result {
      case .success(let data):
        print("Data is \(data)")
        XCTAssertFalse(data.isEmpty)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        XCTFail(error)
      }
    }
  }
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
