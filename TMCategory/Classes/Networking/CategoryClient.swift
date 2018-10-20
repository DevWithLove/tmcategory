//
//  CategoryClient.swift
//  TMCategory
//
//  Created by Tony Mu on 18/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


protocol CategoryRequestDelegate: class {
  func requestSuccess(_ client: CategoryClient, result:Category?)
  func requestFailed(_ client: CategoryClient, errorResponse: Error)
}

class CategoryClient: BaseClient {
  
  private weak var delegate : CategoryRequestDelegate?
  
  init(delegate: CategoryRequestDelegate) {
    self.delegate = delegate
  }
  
  
  func fetch() {
    manager.request(Router.fetchCategory)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseObject{ [weak self] (response: DataResponse<Category>)  in
        guard let strongSelf = self else { return }
        
        switch response.result {
        case .success:
          strongSelf.delegate?.requestSuccess(strongSelf, result: response.result.value)
        case .failure(let error):
          strongSelf.delegate?.requestFailed(strongSelf, errorResponse: error)
        }
    }
  }
}
