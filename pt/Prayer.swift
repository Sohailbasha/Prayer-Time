//
//  Prayer.swift
//  pt
//
//  Created by Ilias Basha on 11/16/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Prayer {
    let name: String
    let time: String
}

class Prayers: NSObject {
    var prayers: [Prayer] = []
    
}
