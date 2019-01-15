//
//  UserPresenterListImplementation.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import Foundation

class UserPresenterListImplementation:UsersListPresenter {
  
  let view:UsersListView
  init(view:UsersListView) {
    self.view = view
  }
  
  func getUsers() {
    WebService.doRequestGet(url: Constants.APIUrls.getUsersURL, succesHandler: { [weak self] (users) in
       if let strongSelf = self {
        strongSelf.view.showUsers(users: users)
      }
    }) { [weak self](error) in
      if let strongSelf = self {
        strongSelf.view.showError(error: error)
      }
    }
  }
}
