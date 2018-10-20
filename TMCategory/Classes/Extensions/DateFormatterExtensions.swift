//
//  DateFormatterExtensions.swift
//  TMCategory
//
//  Created by Tony Mu on 21/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

extension DateFormatter {

  static let englishUnitedStatesLocal = "en_US_POSIX"
  
  static var localDateTimeFomatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    formatter.locale = Locale(identifier: DateFormatter.englishUnitedStatesLocal) // fix for 12/24h
    formatter.timeZone = TimeZone.current
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
  }
  
}
