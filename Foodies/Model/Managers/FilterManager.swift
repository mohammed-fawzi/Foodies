//
//  FilterManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import Foundation


class FilterManager {
    //var filters:[FilterItem] = []
    
    
    func fetch(completionHandler:(_ items:[FilterItem]) -> Swift.Void) {
        var items:[FilterItem] = []
        for data in loadData() {
            items.append(FilterItem(dictionary: data))
        }
        completionHandler(items)
    }
    
    func loadData() -> [[String:AnyObject]]{
       guard let path = Bundle.main.path(forResource: "FilterData", ofType: "plist"),
        let items = NSArray(contentsOfFile: path)  else { return [[:]] }
        return items as! [[String:AnyObject]]
    }
    
}
