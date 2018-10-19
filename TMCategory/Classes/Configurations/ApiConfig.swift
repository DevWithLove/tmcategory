//
//  Config.swift
//  TMCategory
//
//  Created by Tony Mu on 18/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit

protocol ApiConfig {
  
  var base_uri: String { get }
  
  var version: String { get }
  
  var oauth_consurmer_key: String { get }
  
  var oauth_signature_method: String { get }
  
  var oauth_version: String { get }
  
  var oauth_signature: String { get }
}
