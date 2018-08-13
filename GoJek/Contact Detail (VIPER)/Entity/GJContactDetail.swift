//
//  GJContactDetail.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation

struct GJContactDetail: Codable {
  let id: Int
  let firstName: String
  let lastName: String
  let email: String?
  let phone: String?
  let profilePic: String
  let favorite: Bool
  let createdAt: String
  let updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case email = "email"
    case phone = "phone_number"
    case profilePic = "profile_pic"
    case favorite = "favorite"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

