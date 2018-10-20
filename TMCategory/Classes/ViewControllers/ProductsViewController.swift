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
    tableView.delegate = self
    tableView.dataSource = self
    let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.cellId)
    return tableView
    }()
  
  let disposeBag = DisposeBag()

  var productNetworkModel: ProductsNetworkModel!
  var productsViewModel: ProductsViewModel!
  
  var rx_serchBarText: Observable<String> {
    return searchBar.rx.text.orEmpty
      .throttle(0.5, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
  }
  
  var shouldFetchMore = Variable<Bool>(false)
  
  
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
    
    productsViewModel = ProductsViewModel( keywordObservable: rx_serchBarText,
                                           category: category!)
    
    
    productsViewModel.products
      .asObservable()
      .subscribe(onNext: { [weak self] value in
        self?.itemsTableView.reloadData()
      }).disposed(by: disposeBag)
    
//    productNetworkModel = ProductsNetworkModel(keywordObservable: rx_serchBarText)
//
//    productNetworkModel.fetchProducts(categoryId: category!.number!)
//      .drive(itemsTableView.rx.items) { (tv, i, product) in
//        let cell = tv.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: IndexPath(item: i, section: 0)) as! CategoryTableViewCell
//        cell.nameLabel.text = product.title
//        return cell
//      }
//      .disposed(by: disposeBag)
    
  }
  
  // MARK: Additional Helpers
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    
    
    if offsetY > contentHeight - scrollView.frame.height * 4 {
      self.productsViewModel.fatch()
    }
  }
}


extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productsViewModel.products.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellId, for: indexPath) as! CategoryTableViewCell
    cell.nameLabel.text = productsViewModel.products.value[indexPath.row].title
    return cell
  }
  
}
