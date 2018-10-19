//
//  Product.swift
//  TMCategory
//
//  Created by Tony Mu on 19/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct Product: Mappable {
  
  var title: String?
  var id: String?
  var picHref: String?
  var region: String?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    title <- map["Title"]
    id <- map["ListingId"]
    picHref <- map["PictureHref"]
    region <- map["Region"]
  }
  
}
