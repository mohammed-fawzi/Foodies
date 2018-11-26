//
//  ReviewItem.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

struct ReviewItem {
    var rating:Float?
    var title: String?
    var name:String?
    var customerReview:String?
    var date:Date?
    var restaurantID:Int?
    var uuid = UUID().uuidString
    var displayDate:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: self.date as! Date)
    }
}
extension ReviewItem {
    init(data:Review) {
        self.date = data.date
        self.rating = data.rating
        self.title = data.title
        self.name = data.name
        self.customerReview = data.customerReview
        self.restaurantID = Int(data.restaurantID)
        if let uuid = data.uuid { self.uuid = uuid }
    }
}
