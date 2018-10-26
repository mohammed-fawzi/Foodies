//
//  FilterItem.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    let filter:String
    let name: String
    init(dictionary: [String:AnyObject]) {
        name = dictionary["name"] as! String
        filter = dictionary["filter"] as! String
    }
}
