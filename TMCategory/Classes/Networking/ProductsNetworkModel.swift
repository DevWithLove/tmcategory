//
//  ProductsNetworkModel.swift
//  TMCategory
//
//  Created by Tony Mu on 19/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

struct ProductsNetworkModel {
  
  private var shouldFetch: Observable<Bool>
  
  init(shouldFetch: Observable<Bool>) {
    self.shouldFetch = shouldFetch
  }
  
  func fetchProducts(parameters: Parameters) -> Driver<ProductList?> {
    return shouldFetch
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .flatMapLatest { _ -> Observable<(HTTPURLResponse, String)> in
        return RxAlamofire.requestString(Router.fetchProduct(parameters))
          .debug()
          .catchError{ error in
            return Observable.never()
        }
      }
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .map{ (response, json) -> ProductList? in
        if let productList = Mapper<ProductList>().map(JSONString: json){
          return productList
        } else {
          return nil
        }
      }
      .asDriver(onErrorJustReturn: nil)
  }
}


// MARK: Search Parameters

struct ProductFetchParameters {
  let categoryId: String
  let keyword: String
  let page: Int
  let rows: Int
  
  init(categoryId:String, keyword: String, page: Int = 1, rows: Int = 20) {
    self.categoryId = categoryId
    self.keyword = keyword
    self.page = page
    self.rows = rows
  }
  
  var parameters: Parameters {
    var parameters: Parameters = [:]
    parameters["category"] = categoryId
    parameters["search_string"] = keyword
    parameters["page"] = page
    parameters["rows"] = rows
    return parameters
  }
}
