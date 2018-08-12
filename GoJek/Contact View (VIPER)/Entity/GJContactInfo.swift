//
//  GJContactInfo.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import CoreData
/// Contact info
class GJContactInfo : NSManagedObject, Codable {
  /*let contactId: Int
  let firstName: String
  let lastName: String
  let profilePic: String?
  let favorite: Bool
  let url: String*/
  enum CodingKeys: String, CodingKey {
    case contactId = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case profilePic = "profile_pic"
    case favorite = "favorite"
    case url = "url"
  }
  
  // MARK: - Core Data Managed Object
  @NSManaged var contactId: Int32
  @NSManaged var firstName: String?
  @NSManaged var lastName: String?
  @NSManaged var profilePic: String?
  @NSManaged var favorite: Bool
  @NSManaged var url: String?
  
  // MARK: - Decodable
  required convenience init(from decoder: Decoder) throws {
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "GJContacts", in: managedObjectContext) else {
        fatalError("Failed to decode User")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.contactId = (try container.decodeIfPresent(Int32.self, forKey: .contactId))!
    self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
    self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
    self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
    self.favorite = (try container.decodeIfPresent(Bool.self, forKey: .favorite))!
    self.url = try container.decodeIfPresent(String.self, forKey: .url)
  }
  
  // MARK: - Encodable
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(contactId, forKey: .contactId)
    try container.encode(firstName, forKey: .firstName)
    try container.encode(lastName, forKey: .lastName)
    try container.encode(profilePic, forKey: .profilePic)
    try container.encode(favorite, forKey: .favorite)
    try container.encode(url, forKey: .url)
  }
  
}


public extension CodingUserInfoKey {
  // Helper property to retrieve the Core Data managed object context
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
