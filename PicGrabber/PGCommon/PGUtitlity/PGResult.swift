//
//  PGResult.swift
//  PicGrabber
//
//  Created by Shekhar Gupta on 06/12/19.
//  Copyright © 2019 Shekhar. All rights reserved.
//

import UIKit

enum PGResult <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
