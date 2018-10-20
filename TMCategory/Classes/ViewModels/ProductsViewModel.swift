//
//  ProductsViewModel.swift
//  TMCategory
//
//  Created by Tony Mu on 20/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire
import ObjectMapper

final class ProductsViewModel {

  private let disposeBag = DisposeBag()
  private var currentPage = 0
  private var totalCount = 0
  private var currentCount = 0
  private var keyword: Observable<String>
  private var category: Category
  private var currentKeyword: String = ""
  
  private var productClient: ProductsRxClient!
  private var fetchParameterSubject = Variable<Parameters>([:])
  
  var products = Variable<[Product]>([])
  
  var fetchParameter: Parameters {
    return ProductFetchParameters(categoryId: self.category.number!,
                                  keyword: self.currentKeyword,
                                  page: self.nextPage)
                                 .parameters
  }
  
  var count: Int {
    return products.value.count
  }
  
  var nextPage: Int {
    return currentPage + 1
  }
  
  var isFirstPage: Bool {
    return currentPage == 1
  }

  
  init(keywordObservable: Observable<String>, category: Category) {
    self.keyword = keywordObservable
    self.category = category
    self.productClient = ProductsRxClient(parameter: self.fetchParameterSubject.asObservable())
    setup()
  }
  
  func product(at index: Int) -> Product {
    return self.products.value[index]
  }
  
  func fatch() {
    if currentCount < totalCount || currentCount == 0 {
      fetchParameterSubject.value = fetchParameter
    }
  }
  
  // MARK: Additional Helpers
  
  private func setup() {
    keyword.subscribe(onNext: { [weak self] value in
      self?.fetchNewKeyword(keyword: value)
    }).disposed(by: disposeBag)
    
    self.productClient
      .rx_productList
      .drive(onNext: { [weak self] productList in
        guard let this = self else { return }
        if let productList = productList {
          this.updateDataSource(productList: productList)
        }
      }).disposed(by: disposeBag)
  }
  
  private func fetchNewKeyword(keyword: String) {
    self.currentKeyword = keyword
    self.currentPage = 0
    self.totalCount = 0
    self.currentCount = 0
    self.fatch()
  }
  
  private func updateDataSource(productList: ProductList) {
   
    guard let page = productList.page,
          let total = productList.total,
          let products = productList.products else {
          return
    }
    
    self.currentPage = page
    
    if isFirstPage {
      self.products.value = products
      self.totalCount = total
    } else {
      self.products.value.append(contentsOf: products)
    }
    
    self.currentCount = self.products.value.count
    Logger.sharedInstance.info("Products DataSource Count: \(self.count)")
  }
}


