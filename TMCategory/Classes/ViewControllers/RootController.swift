//
//  ViewController.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class RootController: UIViewController {

  lazy var categoryTableView: UITableView = { [weak self] in
    let tv = UITableView(frame: .zero)
    tv.delegate = self
    tv.dataSource = self
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tv.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tv
  }()
 
  var categoryDataSource: [String] = []
  
  
  // MARK: View Lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    categoryDataSource = ["a","b","c"]
    setupViews()
  }

  
  // MARK: Layout
  
  private func setupViews(){
    self.title = "Category"
    view.addSubview(categoryTableView)
    setViewConstraints()
  }
  
  private func setViewConstraints() {
    _ = categoryTableView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  // MARK: Additional Helpers
  
}


extension RootController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
    let viewModel = CategoryViewModel(name: categoryDataSource[indexPath.row], icon: "I")
    cell.viewModel = viewModel
    return cell
  }
}

