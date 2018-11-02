//
//  ExploreViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/14/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let manager = ExploreDataManager()
    var selectedCity:LocationItem?
    var headerView: ExploreHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMapTab()
        manager.fetch()
    }
    
    //hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
  
    // disable map tab if no city is selected
    func checkMapTab(){
        let navBC = self.parent as! UINavigationController
        let tabBarVC = navBC.parent as! UITabBarController
        
        if let mapTab = tabBarVC.tabBar.items?[1] {
            guard selectedCity != nil else {
                mapTab.isEnabled = false
                showAlert()
                return
            }
            mapTab.isEnabled = true
            
        }
    }
    
    func showLocationList(segue:UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? LocationViewController else {
                return
        }
        guard let city = selectedCity else { return }
        viewController.selectedCity = city
    }
    
    func showRestaurantListing(segue:UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantViewController,
           let city = selectedCity,
           let index = collectionView.indexPathsForSelectedItems?.first,
           let type = manager.explore(at: index).name {
            viewController.selectedType = type
            viewController.selectedCity = city
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        case Segue.restaurantList.rawValue:
            showRestaurantListing(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    // do not go to restaurants ViewController if a location is not selected
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue {
            guard selectedCity != nil  else {
                showAlert()
                return false
            }
            return true
        }
        return true
    }
    // show alert if location is not selected
    func showAlert() {
        let alertController = UIAlertController(title: "Location Needed", message:"Please select a location.",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
   
    
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue){}
    
    @IBAction func unwindLocationDone(segue:UIStoryboardSegue){
        if let vc = segue.source as? LocationViewController {
            selectedCity = vc.selectedCity
            let tabBarVC = self.parent?.parent as! UITabBarController
            let MapNavigationController = tabBarVC.children[1] as! UINavigationController
            let MapVc = MapNavigationController.topViewController as! MapViewController
            MapVc.selectedLocation = selectedCity
            
            if let location = selectedCity {
                headerView.locationLabel.text = location.full
            }
        }
        
        checkMapTab()
    }
    
   
}



// MARK:- collection view data source
extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let item = manager.explore(at: indexPath)
        if let name = item.name,
            let image = item.image {
            cell.imageView.image = UIImage(named: image)
            cell.label.text = name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? ExploreHeaderView

        return headerView
    }
}






