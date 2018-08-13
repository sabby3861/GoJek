//
//  WUJSONParser.swift
//  Wunder
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit
import CoreData
typealias JSONDictionary = [String : Any]

enum APIError: Error {
  case message(String)
  
  var localizedDescription: String {
    switch self {
    case .message(let string):
      return string
    }
  }
}
// return .failure(APIError.message(errorMessage))

let baseUrl = "http://gojek-contacts-app.herokuapp.com"
struct JSONParser<Model> {
  var request: URLRequest
  let parse: (Data) throws -> Model
}
enum Result<Model> {
  case success(Model)
  case failure(Error)
}

struct GJJSONParser{
  func request<Model>(resource: JSONParser<Model>, completion: @escaping (Result<Model>) -> Void) {
    URLSession.shared.dataTask(with: resource.request) { (data, _, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      } else {
        if let data = data {
          do {
            let result = try resource.parse(data)
            DispatchQueue.main.async {
              completion(.success(result))
            }
          } catch let error {
            DispatchQueue.main.async {
              completion(.failure(error))
            }
          }
        }
      }
      }.resume()
  }
}

extension JSONParser {
  init(url: ServiceURL, parseJSON: @escaping (Any) throws -> Model) {
    print("Url is \(url.description)")
    // create the url request
    self.request = URLRequest(url: url.description)
    self.request.httpMethod = ServiceManager.payload?.type.httpMethod()
    for (key, value) in (ServiceManager.payload?.headers)! {
      self.request.setValue(value, forHTTPHeaderField: key)
    }
    self.request.httpBody = ServiceManager.payload?.jsonData
    self.parse = { data in
      return try parseJSON(data)
    }
  }
}

struct GJContactService {
  let service = JSONParser<[GJContactInfo]>(url: ServiceURL.ContactsService, parseJSON: { json in
    guard let data = json as? Data else {
      throw APIError.message("Unable to deconde the response")
    }
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
      fatalError("Failed to retrieve managed object context")
    }
    // Parse JSON data
    var managedObjectContext: NSManagedObjectContext?
    let group = DispatchGroup()
    group.enter()
    DispatchQueue.main.async {
      var appDelegate = UIApplication.shared.delegate as! AppDelegate
      managedObjectContext = appDelegate.persistentContainer.viewContext
      group.leave()
    }
    let decoder = JSONDecoder()
    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext!
    return  try  decoder.decode([GJContactInfo].self, from: data)
  })
}

struct GJContactDetailService {
  let service = JSONParser<GJContactDetail>(url: ServiceURL.ContactsDetailService, parseJSON: { json in
    guard let data = json as? Data else {
      throw APIError.message("Unable to deconde the response")
    }
    return  try  JSONDecoder().decode(GJContactDetail.self, from: data)
  })
}

struct GJContactUpdateService {
  let service = JSONParser<JSONDictionary>(url: ServiceURL.ContactsDetailService, parseJSON: { json in
    guard let data = json as? Data else {
      throw APIError.message("Unable to deconde the response")
    }
    let json = try JSONSerialization.jsonObject(with: data, options: [])
    print("Json is \(json)")
    guard let dictionary = json as? JSONDictionary, dictionary["created_at"] as? String != nil else {
      let error: [String: Any] = json as! [String : Any]
      throw APIError.message("Unable to deconde the response")
      
    }
    return  dictionary//try  JSONDecoder().decode(GJContactUpdate.self, from: data)
  })
}


enum ServiceURL {
  case ContactsService;
  case ContactsDetailService;
  var description : URL {
    switch self {
    case .ContactsService: return URL(string: "\(baseUrl)/contacts.json")!;
    case .ContactsDetailService: return URL(string: GJDetailUrl.url)!
    }
  }
}

struct GJDetailUrl {
  static var url: String = ""
}
