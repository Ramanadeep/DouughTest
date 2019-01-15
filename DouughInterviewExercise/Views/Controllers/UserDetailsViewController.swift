//
//  UserDetailsViewController.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 15/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
  
  //MARK:- IBOutlets
  var userNameLabel:UILabel!
  var emailLabel:UILabel!
  var idLabel:UILabel!
  
  //MARK:- Variables
  var user:User?
  
  override func loadView() {
    super.loadView()
    addLabelsToView()
    setUpUIConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let user = user{
      userNameLabel.text = "\(user.firstName!) \(user.lastName!)"
      emailLabel.text = user.email
      idLabel.text = "\(String(describing: user.id!))"
    }
  }
  
  private func addLabelsToView()  {
    userNameLabel = UILabel()
    userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    userNameLabel.numberOfLines = 0
    userNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    userNameLabel.sizeToFit()
    self.view.addSubview(userNameLabel)
    emailLabel = UILabel()
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    emailLabel.numberOfLines = 0
    emailLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    emailLabel.sizeToFit()
    self.view.addSubview(emailLabel)
    idLabel = UILabel()
    idLabel.translatesAutoresizingMaskIntoConstraints = false
    idLabel.numberOfLines = 0
    idLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    idLabel.sizeToFit()
    self.view.addSubview(idLabel)
  }
  
  func setUpUIConstraints() {
    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      userNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      userNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      userNameLabel.heightAnchor.constraint(equalToConstant: 60),
      emailLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      emailLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      emailLabel.heightAnchor.constraint(equalToConstant: 60),
      emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30.0),
      idLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      idLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      idLabel.heightAnchor.constraint(equalToConstant: 60),
      idLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30.0),
      ])
    
    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        userNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0)
        ])
      
    } else {
      let standardSpacing: CGFloat = 8.0
      NSLayoutConstraint.activate([
        userNameLabel.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: standardSpacing)
        ])
    }
  }
  
}
