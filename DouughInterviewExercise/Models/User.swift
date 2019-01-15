//
//  User.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import Foundation
import ObjectMapper

struct User:Mappable {
  var id:Int?
  var firstName:String?
  var lastName:String?
  var email:String?
  
  init?(map: Map) {
    // check if a required properties exists within the JSON.
    if map.JSON["id"] == nil {
      return nil
    }
    if map.JSON["first_name"] == nil {
      return nil
    }
    if map.JSON["last_name"] == nil {
      return nil
    }
    if map.JSON["email"] == nil {
      return nil
    }
  }
  
  mutating func mapping(map: Map) {
    id <- map["id"]
    firstName <- map["first_name"]
    lastName <- map["last_name"]
    email <- map["email"]
  }
  
}
