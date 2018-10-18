//
//  SandBoxApiConfig.swift
//  TMCategory
//
//  Created by Tony Mu on 18/10/18.
//  Copyright © 2018 DevWithLove.com. All rights reserved.
//

import UIKit


/*
 OAuth oauth_consumer_key="A1AC63F0332A131A78FAC304D007E7D1",oauth_signature_method="PLAINTEXT",oauth_timestamp="1539851360",oauth_nonce="5z6pppg0Thr",oauth_version="1.0",oauth_signature="EC7F18B17A062962C6930A8AE88B16C7%26"
 */

class SandBoxApiConfig: ApiConfig {
  
  var base_uri = "https://api.tmsandbox.co.nz"
  
  var version = "v1"
  
  var oauth_consurmer_key = "A1AC63F0332A131A78FAC304D007E7D1"
  
  var oauth_signature_method = "PLAINTEXT"
  
  var oauth_version = "1.0"
  
  var oauth_signature = "EC7F18B17A062962C6930A8AE88B16C7%26"
  
}
