//
//  CommonFunctions.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import Foundation
import UIKit

class Constants {
  struct APIUrls{
    static let getUsersURL = "https://gist.githubusercontent.com/douughios/f3c382f543a303984c72abfc1d930af8/raw/5e6745333061fa010c64753dc7a80b3354ae324e/test-users.json"
  }
}

class AlertUtility {
  
  static let CancelButtonIndex = -1;
  
  class func showAlert(_ onController:UIViewController!, title:String?,message:String? ) {
    showAlert(onController, title: title, message: message, cancelButton: "OK", buttons: nil, actions: nil)
  }
  
  /**
   - parameter title:        title for the alert
   - parameter message:      message for alert
   - parameter cancelButton: title for cancel button
   - parameter buttons:      array of string for title for other buttons
   - parameter actions:      action is the callback which return the action and index of the button which was pressed
   */
  
  
  class func showAlert(_ onController:UIViewController!, title:String?,message:String? = nil ,cancelButton:String = "OK",buttons:[String]? = nil,actions:((_ alertAction:UIAlertAction,_ index:Int)->())? = nil) {
    // make sure it would be run on  main queue
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel) { (action) in
      alertController.dismiss(animated: true, completion: nil)
      actions?(action,CancelButtonIndex)
    }
    alertController.addAction(action)
    if let _buttons = buttons {
      for button in _buttons {
        let action = UIAlertAction(title: button, style: .default) { (action) in
          let index = _buttons.index(of: action.title!)
          actions?(action,index!)
        }
        alertController.addAction(action)
      }
    }
    onController.present(alertController, animated: true, completion: nil)
  }
  
}
