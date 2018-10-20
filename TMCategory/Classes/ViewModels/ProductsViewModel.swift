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
  private var isFetchInProgress = false
  private var shouldFetch = Variable<Bool>(false)
  
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
    setup()
  }
  
  func product(at index: Int) -> Product {
    return self.products.value[index]
  }
  
  func fatch() {
    guard !isFetchInProgress else  { return }
    
    if currentCount < totalCount || currentCount == 0 {
        shouldFetch.value = true
    }
  }
  
  // MARK: Additional Helpers
  
  private func setup() {
    keyword.subscribe(onNext: { [weak self] value in
      self?.fetchNewKeyword(keyword: value)
    }).disposed(by: disposeBag)
    
    shouldFetch.asObservable()
      .debug()
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .flatMapLatest {[weak self] _ -> Observable<(HTTPURLResponse, String)> in
        guard let this = self else { return Observable.never()}
        // Fetching start
        this.isFetchInProgress = true
        
        return RxAlamofire.requestString(Router.fetchProduct(this.fetchParameter))
          .debug()
          .catchError{ error in
            this.isFetchInProgress = false
            return Observable.never()
        }
      }
      .map{ [weak self] response, json in
        guard let this = self else { return }
        if let productList = Mapper<ProductList>().map(JSONString: json) {
          this.updateDataSource(productList: productList)
        }
        // Fetching end
        this.isFetchInProgress = false
      }.subscribe().disposed(by: disposeBag)
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
  }
  
//  func fetch() -> Driver<[Product]>{
//     return keyword
//      .debug()
//      .flatMapLatest {[weak self] text -> Observable<(HTTPURLResponse, String)> in
//        guard let this = self else { return Observable.never() }
//        let p = ProductFetchParameters(categoryId: this.category.number!, keyword: text, page: this.nextPage)
//        return RxAlamofire.requestString(Router.fetchProduct(p.parameters))
//          .debug()
//          .catchError{ error in
//            return Observable.never()}
//      }
//      .map{ response, json -> [Product] in
//        if let productList = Mapper<ProductList>().map(JSONString: json){
//          return productList.products ?? []
//        } else {
//          return []
//        }
//      }
//      .asDriver(onErrorJustReturn: [])
//  }
}


