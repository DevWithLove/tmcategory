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
 
  var categoryDataSource: [Category] = []
  
  lazy var categoryClient: CategoryClient = CategoryClient(delegate: self)
  
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    categoryClient.fetch()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
  }

  
  // MARK: Layout
  
  private func setupViews(){
    // TODO: Localization
    self.title = "Category"
    view.backgroundColor = UIColor.white
    view.addSubview(categoryTableView)
    setViewConstraints()
  }
  
  private func setViewConstraints() {
    _ = categoryTableView.anchor(view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 right: view.rightAnchor,
                                 topConstant: 0, leftConstant: 0, bottomConstant: 0,
                                 rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  // MARK: Additional Helpers
  
}


extension RootViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
    cell.viewModel = categoryDataSource[indexPath.row].toViewModel()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let productsViewController = ProductsViewController()
    productsViewController.category = categoryDataSource[indexPath.row]
    self.navigationController?.pushViewController(productsViewController, animated: true)
  }
}

extension RootViewController: CategoryRequestDelegate {
  func requestSuccess(_ client: CategoryClient, result: Category?) {
    
    if let categories = result?.subcategories {
      categoryDataSource = categories
    } else {
      categoryDataSource = []
    }
    categoryTableView.reloadData()
  }
  
  func requestFailed(_ client: CategoryClient, errorResponse: Error) {
    // TODO: Error handle
  }
}
