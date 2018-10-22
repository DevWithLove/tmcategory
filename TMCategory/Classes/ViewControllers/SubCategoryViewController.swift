//
//  SubCategoryViewController.swift
//  TMCategory
//
//  Created by Tony Mu on 23/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {


  lazy var categoryTableView: UITableView = { [weak self] in
    let tableView = UITableView(frame: .zero)
    tableView.delegate = self
    tableView.dataSource = self
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tableView
    }()


  private var subCategoryDataSource: [Category] = []
  
  var category: Category? {
    didSet {
      guard let subCategories = category?.subcategories else { return }
      subCategoryDataSource = subCategories
    }
  }

  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  // MARK: Layout
  
  private func setupViews(){
    setTitle()
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
  
  private func setTitle() {
    if let categoryName = category?.name {
      self.title = "For \(categoryName)"
    }
  }
  
}

extension SubCategoryViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return subCategoryDataSource.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
    cell.viewModel = subCategoryDataSource[indexPath.row].toViewModel()
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let productsViewController = ProductsViewController()
    productsViewController.category = subCategoryDataSource[indexPath.row]
    self.navigationController?.pushViewController(productsViewController, animated: true)
  }

}
