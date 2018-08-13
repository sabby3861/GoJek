//
//  FBPayLoadHeaders.swift
//  FlixBus
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
protocol PayLoadFormat {
  func formatGetPayload()
  func formatPostPayload(json: [String: Any] )
}
extension PayLoadFormat{
  func formatGetPayload() {
    var payload = GJHTTPPayload(payloadType: .RequestMethodGET)
    payload.addHeader(name: GJHTTPHeaderType.contentType.rawValue, value: GJHTTPMimeType.applicationJSON.rawValue)
    ServiceManager.payload = payload
  }
  
  func formatPostPayload(json: [String: Any] ) {
    var payload = GJHTTPPayload(payloadType: .RequestMethodPOST)
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    payload.jsonData = jsonData!
    payload.addHeader(name: GJHTTPHeaderType.contentType.rawValue, value: GJHTTPMimeType.applicationJSON.rawValue)
    payload.addHeader(name: GJHTTPHeaderType.contentType.rawValue, value: GJHTTPMimeType.applicationJSON.rawValue)
    ServiceManager.payload = nil
    ServiceManager.payload = payload
  }
}

struct ServiceManager {
  static var payload: GJHTTPPayload?
}

struct GJHTTPPayload {
  var type: GJHTTPPayloadType!
  var headers = Dictionary<String, String>()
  var jsonData = Data()
  
  fileprivate init(payloadType: GJHTTPPayloadType) {
    self.type = payloadType
  }
  fileprivate mutating func addHeader(name: String, value: String) {
    headers[name] = value
  }
}

enum GJHTTPMimeType: String {
  case applicationJSON = "application/json; charset=utf-8"
}
enum GJHTTPHeaderType: String{
  case contentType    = "Content-Type"
}

enum GJHTTPMethod: String {
  case get
  case post
}

enum GJHTTPPayloadType{
  case RequestMethodGET
  case RequestMethodPOST
  func httpMethod() -> String {
    switch self{
    case .RequestMethodGET: return GJHTTPMethod.get.rawValue
    case .RequestMethodPOST: return GJHTTPMethod.post.rawValue
    }
  }
}


