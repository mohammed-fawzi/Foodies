//
//  RestaurantDataManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/25/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation
class RestaurantDataManager {
   private var restaurants: [RestaurantItem] = []
    
    var annotations: [RestaurantItem] {
        return restaurants
    }
    
    func fetch(by location: String, withFilter: String = "All", completionHander:()-> Swift.Void) {
        var items:[RestaurantItem] = []
        for item in RestaurantAPIManager.loadJSON(file: location) {
            items.append(RestaurantItem(dictionary: item))
        }
        if withFilter != "All" {
            restaurants = items.filter({$0.cuisines.contains(withFilter)})
        }
        else{
            restaurants = items
        }
        completionHander()
    }
    
    func numberOfItems() -> Int {
        return restaurants.count
    }
    func restaurantItem(at index:IndexPath) -> RestaurantItem {
        return restaurants[index.item]
    }
    
}
