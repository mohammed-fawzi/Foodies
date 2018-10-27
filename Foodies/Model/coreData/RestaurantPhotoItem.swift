//
//  RestaurantPhotoItem.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

struct RestaurantPhotoItem {
    var photo:UIImage?
    var date:Date?
    var restaurantID:Int?
    var uuid = UUID().uuidString
    var photoData: NSData {
        guard let image = photo else {
            return NSData()
        }
        return NSData(data: image.pngData()!)
    }
}

extension RestaurantPhotoItem {
    init(data:RestaurantPhoto) {
        self.date = data.date
        self.restaurantID = Int(data.restaurantID)
        self.photo = UIImage(data: data.photo! , scale:1.0)
        
        if let uuid = data.uuid { self.uuid = uuid }
    }
}
