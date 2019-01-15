//
//  WebServices.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

//Just for the Exercise, otherwise this should have been a Webservice layer which should have taken a request object and handled errors in the base class implementation of the UIViewcontroller.
class WebService {
  static func doRequestGet(url:String, succesHandler: @escaping (_ users: [User]) -> (), errorHandler:
    @escaping (_ error:Error) -> ()){
    let requestURL = URL(string: url)
    let request = URLRequest(url:requestURL!)
    //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if (error != nil) {
        if let error = error{
          errorHandler(error)
        }
      }
      do {
        let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]
        if let theJSONData = try? JSONSerialization.data(
          withJSONObject: result ?? [],
          options: []) {
          let theJSONText = String(data: theJSONData,
                                   encoding: .ascii)
          let usersArray = Mapper<User>().mapArray(JSONString: theJSONText!)
          succesHandler(usersArray!)
        }
      } catch {
        print("Error -> \(error)")
      }
    }
    dataTask.resume()
  }
}
