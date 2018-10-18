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
  
  static let oauthHeaderKey = "Authorization"
  
  static var apiConfig: ApiConfig = SandBoxApiConfig()
  
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
      return "/\(Router.apiConfig.version)/Categories/0.json"
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = Foundation.URL(string: Router.apiConfig.base_uri)!
    var request = URLRequest(url: url.appendingPathComponent(path))
    
    request.httpMethod = method.rawValue
    request.addValue(Router.apiConfig.oauthHeader, forHTTPHeaderField: Router.oauthHeaderKey)
    
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

fileprivate extension ApiConfig {
  
  var oauthHeader: String {
    return """
    OAuth oauth_consumer_key=\(self.oauth_consurmer_key),oauth_signature_method=\(self.oauth_signature_method),oauth_version=\(self.oauth_version),oauth_signature=\(self.oauth_signature)
    """
  }
  
}
