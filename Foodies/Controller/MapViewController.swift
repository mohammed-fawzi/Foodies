//
//  MapViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    let manager = MapDataManager()
    var selectedRestaurant: RestaurantItem?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

    }
    

    func initialize() {
        mapView.delegate = self
        manager.fetch { (annotations) in
            addMap(annotations)
        }
    }
    func addMap(_ annotations:[RestaurantItem]) {
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
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
            av.image = UIImage(named: "custom-annotation")
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = mapView.selectedAnnotations.first {
            selectedRestaurant = annotation as? RestaurantItem
        }
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showDetail.rawValue {
            let vc = segue.destination as? RestaurantDetailViewController
            vc?.selectedRestaurant = selectedRestaurant
        }
    }

}
