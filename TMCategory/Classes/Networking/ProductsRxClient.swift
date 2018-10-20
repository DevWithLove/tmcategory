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

struct ProductsRxClient {
  
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
