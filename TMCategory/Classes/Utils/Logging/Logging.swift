//
//  Logging.swift
//  TMCategory
//
//  Created by Tony Mu on 19/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

protocol Logging {
  
  // Literal expression (#file,#line,#column,#function) have to be defined on the top level of the call,
  // in order to target to the current module.
  
  /// The lowest priority level, use this one for contextual information
  func verbose(_ message: String, filePath: String, line: Int, column: Int, funcname: String)
  
  /// Use this level for printing variables and results that will help you fix a bug or slove a problem
  func debug(_ message: String, filePath: String, line: Int, column: Int, funcname: String)
  
  /// This is a typically used for information useful in a more general support context
  func info(_ message: String, filePath: String, line: Int, column: Int, funcname: String)
  
  /// Use this level when reaching a condition that won't necessarily cause a problem but strongly leads the app in that direction
  func warning(_ message: String, filePath: String, line: Int, column: Int, funcname: String)
  
  /// The most serious and highest priority log level
  func error(_ message: String, error: NSError, userInfo: [String : Any]?, filePath: String, line: Int, column: Int, funcname: String)

}

// We have to use extension methods to set the default values since protocols don't direct support default values
extension Logging {
  
  func verbose(_ message: String, filePath: String = #file, line: Int = #line, column: Int = #column, funcname: String = #function) {
    verbose(message, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func debug(_ message: String, filePath: String = #file, line: Int = #line, column: Int = #column, funcname: String = #function)  {
    debug(message, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func info(_ message: String, filePath: String = #file, line: Int = #line, column: Int = #column, funcname: String = #function) {
    info(message, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func warning(_ message: String, filePath: String = #file, line: Int = #line, column: Int = #column, funcname: String = #function) {
    warning(message, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func error(_ message: String, error: NSError, userInfo: [String : Any]?, filePath: String = #file, line: Int = #line, column: Int = #column, funcname: String = #function) {
    self.error(message, error: error, userInfo: userInfo, filePath: filePath, line: line, column: column, funcname: funcname)
  }
}
