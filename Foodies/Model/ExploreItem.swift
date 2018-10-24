//
//  ExploreData.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/14/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

struct ExploreItem {
    var name:String?
    var image:String?
    
    init(dict:[String:AnyObject]) {
        self.name = dict["name"] as? String
        self.image = dict["image"] as? String
    }
}
