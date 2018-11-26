//
//  PhotosViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/27/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let manager = CoreDataManager()
    var photos:[RestaurantPhotoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPhotos()
    }
    
    func checkPhotos() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            print("*********\(id)***********")
            if photos.count > 0 { photos.removeAll() }
            photos = manager.fetchPhotos(by: id)
            
            if photos.count > 0 {
                collectionView.backgroundView = nil
            }
            else{
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Photos")
                view.set(description: "There are currently no photos")
                collectionView.backgroundView = view
            }
            collectionView.reloadData()
        }
    }
}
    


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        if let photo = photos[indexPath.row].photo {
            cell.imageView.image = photo
        }
        else {
            cell.imageView.image = UIImage(named: "bar")
        }
        return cell
    }
    
        
}
