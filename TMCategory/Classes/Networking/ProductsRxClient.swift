//
//  ProductsRxClient.swift
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
  
  lazy var rx_productList: Driver<ProductList?> = self.fetchProducts()
  private var parameter: Observable<Parameters>
  
  init(parameter: Observable<Parameters>) {
    self.parameter = parameter
  }
  
  private func fetchProducts() -> Driver<ProductList?> {
    return parameter
      .distinctUntilChanged({ (first, second) -> Bool in
        return NSDictionary(dictionary: first).isEqual(to: second)
      })
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .flatMapLatest { param -> Observable<(HTTPURLResponse, String)> in
        Logger.sharedInstance.info("Fetching param: \(param)")
        return RxAlamofire.requestString(Router.fetchProduct(param))
          //.debug()
          .catchError{ error in
            return Observable.never()
        }
      }
      .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .map{ (response, json) -> ProductList? in
        return Mapper<ProductList>().map(JSONString: json)
      }
      .asDriver(onErrorJustReturn: nil)
  }
}
