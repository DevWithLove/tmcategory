//
//  ProductList.swift
//  TMCategory
//
//  Created by Tony Mu on 19/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct ProductList: Mappable {
  
  var total: Int?
  var page: Int?
  var pageSize: Int?
  var products: [Product]?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    total <- map["TotalCount"]
    page <- map["Page"]
    pageSize <- map["PageSize"]
    products <- map["List"]
  }
  
}
