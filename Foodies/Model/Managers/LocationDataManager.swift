//
//  LocationDataManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

class LocationDataManager {
   private var locations:[LocationItem] = []
    
    init() {
        fetch()
    }
    func fetch() {
        var item = LocationItem()
        for location in loadData() {
            if let city = location["city"] ,
                let state = location["state"]  {
                item.state = state
                item.city = city
                locations.append(item)
            }
        }
    }
    
    func loadData() -> [[String:String]] {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"),
        let items = NSArray(contentsOfFile: path) else { return [[:]] }
        
        return items as! [[String: String]]
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    func locationItem(at index:IndexPath) -> LocationItem {
        return locations[index.item]
    }
    
    func findLocation(by name:String) -> (isFound:Bool, position:Int) {
        var index = 0
        for item in locations {
            if item.city == name {
                return (isFound:true, position: index)
            }
            else{
                index += 1
            }
        }
       return (isFound:false, position:0)
    }
    
}
