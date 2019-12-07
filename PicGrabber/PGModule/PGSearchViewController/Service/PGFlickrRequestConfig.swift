//
//  PGFlickrRequestConfig.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

enum PGFlickrRequestConfig {
    case searchRequest(String, Int)
    
    var value: PGRequest? {
        switch self {
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: PGConstant.searchURL, searchText, pageNo)
            let reqConfig = PGRequest.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
