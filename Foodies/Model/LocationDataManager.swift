//
//  LocationDataManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

class LocationDataManager {
   private var locations:[String] = []
    
    init() {
        fetch()
    }
    func fetch() {
        for location in loadData() {
            if let city = location["city"] ,
                let state = location["state"]  {
                locations.append("\(city), \(state)")
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
    func locationItem(at index:IndexPath) -> String {
        return locations[index.item]
    }
    
    func findLocation(by name:String) -> (isFound:Bool, position:Int) {
        guard let index = locations.index(of: name) else
        { return (isFound:false, position:0) }
        return (isFound:true, position:index)
    }
    
}
