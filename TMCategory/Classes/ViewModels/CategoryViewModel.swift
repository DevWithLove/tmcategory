//
//  CategoryViewModel.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

enum CategoryType: String {
  
  case motors = "0001"
  case property = "0350"
  case jobs = "5000"
  case antiquesCollectables = "0187"
  case art = "0339"
  case babyGear = "0351"
  case books = "0139"
  case buildingRenovation = "5964"
  case businessFamming = "0010"
  case clothingFashion = "0153"
  case computer = "0002"
  case crafts = "0341"
  case electronicsPhotography = "0124"
  case flatmates = "2975"
  case gaming = "0202"
  case healthBeauty = "4798"
  case homeLiving = "0004"
  case unknown = "0000"
  
  var icon: String {
    switch self {
      case .motors: return "\u{f063}"
      case .property: return "\u{f015}"
    default:
      return "\u{f063}"
    }
  }
  
}

struct CategoryViewModel {
  let name: String
  let type: CategoryType
}
