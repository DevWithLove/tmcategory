//
//  UIFontExtensions.swift
//  TMCategory
//
//  Created by Tony Mu on 17/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

extension UIFont {
  
  static var TitilliumWeb: TitilliumWebFont {
    return TitilliumWebFont()
  }
  
//  static var Icon: IconFont {
//    return IconFont()
//  }
}


fileprivate protocol CustomFont {
  var familyName: String {get}
  var defaultSize: CGFloat {get}
}

struct TitilliumWebFont: CustomFont {
  var familyName: String
  var defaultSize: CGFloat
  
  init() {
    familyName = "TitilliumWeb"
    defaultSize = 12
  }
  
  var regular: UIFont {
    return UIFont(name: "\(familyName)-Regular", size: defaultSize)!
  }
  
  var semiBold: UIFont {
    return UIFont(name: "\(familyName)-SemiBold", size: defaultSize)!
  }
  
  var light: UIFont {
    return UIFont(name: "\(familyName)-Light", size: defaultSize)!
  }
}

//struct IconFont: CustomFont {
//
//  var familyName: String
//  var defaultSize: CGFloat
//
//  init() {
//    familyName = "FontAwesome"
//    defaultSize = 12
//  }
//
//  var regular: UIFont {
//    return UIFont(name: "\(familyName)", size: defaultSize)!
//  }
//}
