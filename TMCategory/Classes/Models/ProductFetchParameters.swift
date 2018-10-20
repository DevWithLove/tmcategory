//
//  ProductFetchParameter.swift
//  TMCategory
//
//  Created by Tony Mu on 20/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import Alamofire

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
