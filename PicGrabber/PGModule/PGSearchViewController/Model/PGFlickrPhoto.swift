//
//  PGFlickrPhoto.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

struct PGFlickrPhoto: Codable {
    let farm : Int
    let id : String
    let isfamily : Int
    let isfriend : Int
    let ispublic : Int
    let owner: String
    let secret : String
    let server : String
    let title: String
    
    var imageURL: String {
        let urlString = String(format: PGConstant.imageURL, farm, server, id, secret)
        return urlString
    }
}
