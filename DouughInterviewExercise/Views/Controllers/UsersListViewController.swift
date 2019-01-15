//
//  UsersListViewController.swift
//  DouughInterviewExercise
//
//  Created by raman singh on 14/01/19.
//  Copyright © 2019 raman singh. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController, UsersListView {
  
  //MARK:- IBOutlets
  var segmentControl:UISegmentedControl!
  var userTableView:UITableView!
  var activityIndicator:UIActivityIndicatorView!
  
  //MARK:- Varibles
  var presenter:UsersListPresenter!
  var usersArray:[User]!
  var usersArraySorted:[User]!
  
  override func loadView() {
    super.loadView()
    addSegmentControlToView()
    setSegmentControlConstraints()
    addTableView()
    setTableViewConstraints()
    addActivityIndicatorToView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Users List"
    presenter = UserPresenterListImplementation(view: self)
    showActivityView()
    presenter.getUsers()
    // Do any additional setup after loading the view.
  }
  
  //MARK:- Helper Methods
  private func addSegmentControlToView() {
    let items = ["First", "Last", "ID"]
    segmentControl = UISegmentedControl(items: items)
    segmentControl.selectedSegmentIndex = 0
    segmentControl.translatesAutoresizingMaskIntoConstraints = false
    // Add target action method
    segmentControl.addTarget(self, action:#selector(changeColor), for: .valueChanged)
    self.view.addSubview(segmentControl)
  }
  
  private func setSegmentControlConstraints() {
    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      segmentControl.heightAnchor.constraint(equalToConstant: 60)
      ])
    
    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        segmentControl.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0)
        ])
      
    } else {
      let standardSpacing: CGFloat = 8.0
      NSLayoutConstraint.activate([
        segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: standardSpacing)
        ])
    }
    segmentControl.layer.borderWidth = 1.0
    segmentControl.layer.borderColor = UIColor.blue.cgColor
    segmentControl.layer.cornerRadius = 10.0
    segmentControl.backgroundColor = UIColor.blue
    segmentControl.tintColor = UIColor.white
  }
  
  private func addTableView() {
    userTableView = UITableView()
    userTableView.translatesAutoresizingMaskIntoConstraints = false
    userTableView.rowHeight = UITableView.automaticDimension
    userTableView.estimatedRowHeight = 44
    self.view.addSubview(userTableView)
  }
  
  private func setTableViewConstraints() {
    userTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
    userTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 30.0).isActive = true
    userTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        guide.bottomAnchor.constraint(equalToSystemSpacingBelow: userTableView.bottomAnchor, multiplier: 1.0)
        ])
    } else {
      let standardSpacing: CGFloat = 8.0
      NSLayoutConstraint.activate([
        bottomLayoutGuide.topAnchor.constraint(equalTo: userTableView.bottomAnchor, constant: standardSpacing)
        ])
    }
    userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  private func addActivityIndicatorToView() {
    activityIndicator = UIActivityIndicatorView(style: .gray)
    activityIndicator.center = self.view.center
    self.view.addSubview(activityIndicator)
  }
  
  private func showActivityView(){
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
  }
  
  private func hideActivityView(){
    DispatchQueue.main.async {
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
    }
  }
  
  @objc func changeColor(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 1:
      usersArraySorted = usersArray.sorted { $0.lastName! < $1.lastName! }
      DispatchQueue.main.async {
        self.userTableView.reloadData()
      }
    case 2:
      usersArraySorted = usersArray.sorted { $0.id! < $1.id! }
      DispatchQueue.main.async {
        self.userTableView.reloadData()
      }
    default:
      usersArraySorted = usersArray.sorted { $0.firstName! < $1.firstName! }
      DispatchQueue.main.async {
        self.userTableView.reloadData()
      }
    }
  }
  
  //MARK:- View Methods
  func showUsers(users:[User]) {
    hideActivityView()
    self.usersArray = users
    usersArraySorted = usersArray.sorted { $0.firstName! < $1.firstName! }
    DispatchQueue.main.async {
      self.userTableView.dataSource = self
      self.userTableView.delegate = self
      self.userTableView.reloadData()
    }
  }
  
  func showError(error: Error) {
    AlertUtility.showAlert(self, title: error.localizedDescription)
  }
}

extension UsersListViewController:UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usersArraySorted?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! UserTableViewCell
    cell.userNameLabel.text = "\(String(describing: usersArraySorted![indexPath.row].firstName!)) \(String(describing: usersArraySorted![indexPath.row].lastName!))"
    cell.emailLabel.text = "\(String(describing: usersArraySorted![indexPath.row].email!))"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let userDetailsViewController = UIStoryboard.loadUserDetailsViewController()
    userDetailsViewController.user = usersArraySorted[indexPath.row]
    self.navigationController?.pushViewController(userDetailsViewController, animated: true)
  }
}

//MARK:- UITableViewCell
class UserTableViewCell: UITableViewCell {
  
  let userNameLabel = UILabel()
  let emailLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    userNameLabel.numberOfLines = 0
    userNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    userNameLabel.sizeToFit()
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    emailLabel.numberOfLines = 0
    emailLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    emailLabel.sizeToFit()
    
    contentView.addSubview(userNameLabel)
    contentView.addSubview(emailLabel)
    
    let viewsDict = [
      "username" : userNameLabel,
      "message" : emailLabel,
      ] as [String : Any]
    
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[message]-|", options: [], metrics: nil, views: viewsDict))
    emailLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 1.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


