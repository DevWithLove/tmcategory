//
//  BaseClient.swift
//  TMCategory
//
//  Created by Tony Mu on 18/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import Alamofire

class BaseClient {
  
  // Alamofire Manager: Responsible for creating and managing `Request` objects
  var manager: SessionManager = BaseClient.defaultManager
  
  static let defaultManager: SessionManager = {
    let configuration: URLSessionConfiguration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    return SessionManager(configuration: configuration)
  }()
  
}

