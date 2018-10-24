//
//  RestaurantViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    

    
    
    var selectedRestaurant:RestaurantItem?
    var selectedCity:String?
    var selectedType:String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("selected city \(selectedCity as Any)")
        print("selected type \(selectedType as Any)")
        //print(RestaurantAPIManager.loadJSON(file: location))
    }
    
}



//MARK:- collectionView dataSource
extension RestaurantViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
        
        return cell
    }
}
