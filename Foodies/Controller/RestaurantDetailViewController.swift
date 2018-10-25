//
//  RestaurantDetailViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/24/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    @IBOutlet weak var imageMap: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var overAllRating: UILabel!
    @IBOutlet weak var tableDetailsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var headerAdressLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIBarButtonItem!
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
      
    }
    
    func initialize() {
        setupLabels()
        createMap()
    }

   
    func setupLabels() {
        guard let restaurant = selectedRestaurant else { return }
        if let name = restaurant.name {
            nameLabel.text = name
            title = name
        }
        if let cuisine = restaurant.subtitle { cuisineLabel.text = cuisine }
        if let address = restaurant.address {
            addressLabel.text = address
            headerAdressLabel.text = address
        }
        tableDetailsLabel.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant, let long = annotation.longitude, let lat = annotation.latitude else{return}
            let location = CLLocationCoordinate2D(latitude: lat,longitude: long)
            takeSnapShot(with: location)
        }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyLine = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyLine.boundingMapRect)
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.imageMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imageMap.image = image
                }
            }
        }
    }


}

 // MARK: - Table view data source
extension RestaurantDetailViewController {
    
}


// MARK: - Table view delegate
extension RestaurantDetailViewController{
    
}
