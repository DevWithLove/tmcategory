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
  
  private var keyWord: Observable<String>
  
  init(keywordObservable: Observable<String>) {
    self.keyWord = keywordObservable
  }
  
  func fetchProducts(categoryId: String) -> Driver<[Product]> {
    return keyWord
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .flatMapLatest { text -> Observable<(HTTPURLResponse, String)> in
        let search = SearchParameters(categoryId: categoryId, keyword: text)
        return RxAlamofire.requestString(Router.searchProduct(search.parameters))
          .debug()
          .catchError{ error in
            return Observable.never()
        }
      }
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .map{ (response, json) -> [Product] in
        if let productList = Mapper<ProductList>().map(JSONString: json){
          return productList.products ?? []
        } else {
          return []
        }
      }
      .asDriver(onErrorJustReturn: [])
  }
}


// MARK: Search Parameters

fileprivate struct SearchParameters {
  let categoryId: String
  let keyword: String
  let page: Int
  
  init(categoryId:String, keyword: String, page: Int = 1) {
    self.categoryId = categoryId
    self.keyword = keyword
    self.page = page
  }
  
  var parameters: Parameters {
    var parameters: Parameters = [:]
    parameters["category"] = categoryId
    parameters["search_string"] = keyword
    parameters["page"] = page
    return parameters
  }
}
