//
//  UsersListPresenter.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import Foundation

protocol UsersListPresenter {
  func getUsers()
}

protocol UsersListView {
  func showUsers(users:[User])
  func showError(error:Error)
}
