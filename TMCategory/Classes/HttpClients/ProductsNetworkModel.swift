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
      .flatMapLatest { text -> Observable<(HTTPURLResponse, String)> in
        var parameters: Parameters = [:]
          parameters["category"] = categoryId
          parameters["search_string"] = text
        return RxAlamofire.requestString(Router.searchProduct(parameters))
                  .debug()
                  .catchError{ error in
                  return Observable.never()
           }
        }
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
