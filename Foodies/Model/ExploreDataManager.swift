//
//  ExploreDataManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/14/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation

class ExploreDataManager {
    
    fileprivate var items:[ExploreItem] = []
    
    func loadData() -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
            let items = NSArray(contentsOfFile: path)  else { return [[:]]}
        
        return items as! [[String:AnyObject]]
    }
    
    func fetch() {
        for item in loadData() {
            let data = ExploreItem(dict: item)
            items.append(data)
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    func explore(at index:IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
}
