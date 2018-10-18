//
//  Category.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct Category: Mappable {
  
  var name: String?
  var number: String?
  var path: String?
  var subcategories: [Category]?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    name <- map["Name"]
    number <- map["Number"]
    path <- map["Path"]
    subcategories <- map["Subcategories"]
  }
  
}
