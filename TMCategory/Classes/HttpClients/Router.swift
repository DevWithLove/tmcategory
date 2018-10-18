//
//  Router.swift
//  TMCategory
//
//  Created by Tony Mu on 18/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import Alamofire

enum Router: Alamofire.URLRequestConvertible {
  
  static let baseUri = "https://api.tmsandbox.co.nz"
  
  case fetchCategory
  
  private var method: HTTPMethod {
    switch self {
    case .fetchCategory:
      return .get
    }
  }
  
  private var path: String {
    //let version = Router.apiConfig.version
    
    switch self {
    case .fetchCategory:
      return "/v1/Categories/0.json"
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = Foundation.URL(string: Router.baseUri)!
    var request = URLRequest(url: url.appendingPathComponent(path))
    
    request.httpMethod = method.rawValue
    
    switch self {
    case .fetchCategory:
      return try requestWithParameter(request, parameters: [:])
    default:
      return request
    }
  }
  
  
  // MARK: Helper Methods
  
  fileprivate func requestWithParameter(_ request:URLRequest, parameters: [String:AnyObject]) throws -> URLRequest {
    return try URLEncoding.default.encode(request, with: parameters)
  }
  
  
}
