//
//  ItemsViewController.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: .zero)
    return searchBar
  }()
  
  lazy var itemsTableView: UITableView = { [weak self] in
    let tableView = UITableView(frame: .zero)
    tableView.delegate = self
    tableView.dataSource = self
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tableView
    }()
  
  var itemDataSource: [String] = []
  
  
  // MARK: View Lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    itemDataSource = ["item1","item2","item3"]
    setupViews()
  }
  
  
  // MARK: Layout
  
  private func setupViews(){
    self.title = "Items"
    view.backgroundColor = UIColor.white
    view.addSubview(searchBar)
    view.addSubview(itemsTableView)
    setViewConstraints()
  }
  
  private func setViewConstraints() {
    _ = searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 56)
    _ = itemsTableView.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
  //  let viewModel = CategoryViewModel(name: itemDataSource[indexPath.row], number: "I")
   // cell.viewModel = nil
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected : \(indexPath.row)")
  }
}

