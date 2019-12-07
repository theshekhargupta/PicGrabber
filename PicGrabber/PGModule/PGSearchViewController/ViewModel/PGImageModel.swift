//
//  PGImageModel.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

struct PGImageModel {

    let imageURL: String
    
    init(withPhotos photo: PGFlickrPhoto) {
        imageURL = photo.imageURL
    }
}

