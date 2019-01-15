//
//  StoryBoardExtension.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 15/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
  case main = "Main"
}

fileprivate extension UIStoryboard {
  
  static func loadFromMain(_ identifier: String) -> UIViewController {
    return load(from: .main, identifier: identifier)
  }

  static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
    let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return uiStoryboard.instantiateViewController(withIdentifier: identifier)
  }
}

// MARK: App View Controllers

extension UIStoryboard {
  class func loadUserDetailsViewController() -> UserDetailsViewController {
    return loadFromMain("UserDetailsViewController") as! UserDetailsViewController
  }
  
}
