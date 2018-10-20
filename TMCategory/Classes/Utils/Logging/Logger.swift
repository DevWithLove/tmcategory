//
//  Logger.swift
//  TMCategory
//
//  Created by Tony Mu on 19/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

fileprivate enum LogType: String {
  case verbose = "[📣]"
  case debug = "[📝]"
  case info = "[ℹ️]"
  case warning = "[⚠️]"
  case error = "[‼️]"
}

final class Logger: NSObject  {
  
  /**
   Get the singleton instance
   
   - Returns: Logger
   */
  class var sharedInstance: Logger {
    struct Singleton{
      static let instance = Logger()
    }
    return Singleton.instance
  }
  
  // Log message on console during debuging
  private func logToConsole(_ message: String,
                                 type: LogType,
                                error: NSError? = nil,
                             filePath: String,
                                 line: Int,
                               column: Int,
                             funcname: String) {
    
    #if DEBUG
    print("\(Date().toString())\(type.rawValue)[\(filePath.fileName)]:\(line) \(column) \(funcname) -> \(message)")
  
    if let error = error {
      print(error.description)
    }
    #endif
  }
  
}

extension Logger: Logging {
  func verbose(_ message: String, filePath: String, line: Int, column: Int, funcname: String) {
    logToConsole(message, type: .verbose, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func debug(_ message: String, filePath: String, line: Int, column: Int, funcname: String)  {
    logToConsole(message, type: .debug, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func info(_ message: String, filePath: String, line: Int, column: Int, funcname: String)  {
    logToConsole(message, type: .info, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func warning(_ message: String, filePath: String, line: Int, column: Int, funcname: String)  {
    logToConsole(message, type: .warning, filePath: filePath, line: line, column: column, funcname: funcname)
  }
  
  func error(_ message: String, error: NSError, userInfo: [String : Any]?, filePath: String, line: Int, column: Int, funcname: String)  {
    logToConsole(message, type: .error, filePath: filePath, line: line, column: column, funcname: funcname)
  }
}

// MARK: Helper

fileprivate extension Date {
  func toString() -> String {
    return DateFormatter.localDateTimeFomatter.string(from: self as Date)
  }
}

fileprivate extension String {
  var fileName: String {
    let components = self.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last!
  }
}
