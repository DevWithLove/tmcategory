//
//  ViewController.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

  lazy var categoryTableView: UITableView = { [weak self] in
    let tableView = UITableView(frame: .zero)
    tableView.delegate = self
    tableView.dataSource = self
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tableView
  }()
 
  var categoryDataSource: [String] = []
  
  lazy var categoryClient: CategoryClient = CategoryClient(delegate: self)
  
  // MARK: View Lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    categoryDataSource = ["a","b","c"]
    categoryClient.fetch()
    setupViews()
  }

  
  // MARK: Layout
  
  private func setupViews(){
    self.title = "Category"
    view.backgroundColor = UIColor.white
    view.addSubview(categoryTableView)
    setViewConstraints()
  }
  
  private func setViewConstraints() {
    _ = categoryTableView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  // MARK: Additional Helpers
  
}


extension RootViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
    let viewModel = CategoryViewModel(name: categoryDataSource[indexPath.row], icon: "I")
    cell.viewModel = viewModel
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let itemsViewController = ItemsViewController()
    self.navigationController?.pushViewController(itemsViewController, animated: true)
    print("selected : \(indexPath.row)")
  }
}

extension RootViewController: CategoryRequestDelegate {
  func requestSuccess(_ client: CategoryClient, result: [Category]?) {
    
  }
  
  func requestFailed(_ client: CategoryClient, errorResponse: Error) {
    
  }
  
  
}

