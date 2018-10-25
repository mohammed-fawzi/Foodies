//
//  RestaurantItem.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit
import MapKit

class RestaurantItem: NSObject,MKAnnotation,Decodable {
    var name: String?
    var cuisines:[String] = []
    var latitude: Double?
    var longitude:Double?
    var address:String?
    var postalCode:String?
    var state:String?
    var imageURL:String?
    
    init(dictionary:[String:AnyObject]) {
        if let lat = dictionary["lat"] as? Double {self.latitude = lat}
        if let long = dictionary["long"] as? Double {self.longitude = long}
        if let name = dictionary["name"] as? String {self.name = name}
        if let cuisines = dictionary["cuisines"] as? [String] {self.cuisines = cuisines}
        if let address = dictionary["address"] as? String {self.address = address}
        if let postalCode = dictionary["postal_code"] as? String {self.postalCode = postalCode}
        if let state = dictionary["state"] as? String {self.state = state}
        if let image = dictionary["image_url"] as? String {self.imageURL = image}
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String?{
        if cuisines.isEmpty { return ""}
        else if cuisines.count == 1 {return cuisines.first}
        else{ return cuisines.joined(separator: ", ")}
    }
    
    var coordinate: CLLocationCoordinate2D{
        guard let lat = latitude,
              let long = longitude else { return CLLocationCoordinate2D() }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }


}
