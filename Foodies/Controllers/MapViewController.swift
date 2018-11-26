//
//  MapViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let manager = RestaurantDataManager()
    var selectedRestaurant: RestaurantItem?
    var selectedLocation: LocationItem?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    

    func initialize() {
        if let selectedCity = selectedLocation?.city {
            manager.fetch(by: selectedCity) {
                addMap(manager.annotations)
            }
        }
        
    }
    func addMap(_ annotations:[RestaurantItem]) {
        let initialLocation = (manager.annotations[1].coordinate)
        centerMapOnLocation(location: initialLocation)
        mapView.addAnnotations(manager.annotations)
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    

}


// MARK:- mapView delegate
extension MapViewController: MKMapViewDelegate {
    
    // create custom annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        
        // checking if the annotation is the one for user location then do nothing
        guard  !annotation.isKind(of: MKUserLocation.self) else {return nil}
        
        // checking if there is a previously created annotation to reuse if not create a new one
        var annotationView:MKAnnotationView?
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        }
        else{
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        // make sure that our custom annotation will show a callout
        if let av = annotationView {
            av.canShowCallout = true
            av.image = UIImage(named: "location-pin")
        }
        
        return annotationView
    }
    
    
    // create the callout accessory
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = mapView.selectedAnnotations.first {
            selectedRestaurant = annotation as? RestaurantItem
        }
        // show restaurantDetail viewController
        let navVC = self.parent as! UINavigationController
        let storyboard = UIStoryboard(name: "ResturantDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "restaurantDetails") as! RestaurantDetailViewController
        vc.selectedRestaurant = selectedRestaurant
        navVC.pushViewController(vc, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage(named: "location-pin-active")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "location-pin")
    }
    
    
}
