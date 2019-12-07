//
//  PGPhotos.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

struct PGPhotos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [PGFlickrPhoto]
    let total: String
}
