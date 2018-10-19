//
//  ItemsViewController.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController {
  
  var category: Category?
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: .zero)
    return searchBar
  }()
  
  lazy var itemsTableView: UITableView = { [weak self] in
    let tableView = UITableView(frame: .zero)
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tableView
    }()
  
  let disposeBag = DisposeBag()
  
  var productNetworkModel: ProductsNetworkModel!
  
  var rx_serchBarText: Observable<String> {
    return searchBar.rx.text.orEmpty
      .throttle(0.5, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
  }
  
  
  // MARK: View Lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupRx()
  }
  
  
  // MARK: Layout
  
  private func setupViews(){
    setTitle()
    view.backgroundColor = UIColor.white
    view.addSubview(searchBar)
    view.addSubview(itemsTableView)
    setViewConstraints()
  }
  
  private func setViewConstraints() {
    _ = searchBar.anchor(view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         topConstant: 0, leftConstant: 0, bottomConstant: 10,
                         rightConstant: 0, widthConstant: 0, heightConstant: 56)
    
    _ = itemsTableView.anchor(searchBar.bottomAnchor,
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
  
  // MARK: Rx Helper
  
  private func setupRx() {
    
    productNetworkModel = ProductsNetworkModel(keywordObservable: rx_serchBarText)
    
    productNetworkModel.fetchProducts(categoryId: category!.number!)
      .drive(itemsTableView.rx.items) { (tv, i, product) in
        let cell = tv.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: IndexPath(item: i, section: 0)) as! CategoryTableViewCell
        cell.nameLabel.text = product.title
        return cell
      }
      .disposed(by: disposeBag)
    
  }
  
  // MARK: Additional Helpers
  
}

