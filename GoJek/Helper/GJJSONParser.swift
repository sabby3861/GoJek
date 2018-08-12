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
    DispatchQueue.main.async {
      var appDelegate = UIApplication.shared.delegate as! AppDelegate
      managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    let decoder = JSONDecoder()
    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext!
    return  try  decoder.decode([GJContactInfo].self, from: data)
  })
}

enum ServiceURL {
  case ContactsService;
  var description : URL {
    switch self {
    case .ContactsService: return URL(string: "\(baseUrl)/contacts.json")!;
    }
  }
}
