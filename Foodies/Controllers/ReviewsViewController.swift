//
//  ReviewsViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/27/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRestaurantID:Int?
    let manager = CoreDataManager()
    var reviews: [ReviewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
    
    

}


private extension ReviewsViewController {
    func initialize() {
        setupCollectionView()
    }
    func setupDefaults() {
        checkReviews()
    }
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }
    
    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
             if reviews.count > 0 { reviews.removeAll() }
             reviews = manager.fetchReviews(by: id)
            
            if reviews.count > 0 {
                collectionView.backgroundView = nil
            }
            else{
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews")
                view.set(description: "There are currently no reviews")
                collectionView.backgroundView = view
            }
            

            collectionView.reloadData()
        }
    }
}


extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let review = reviews[indexPath.row]
        cell.titleLabel.text = review.title
        cell.nameLabel.text = review.name
        cell.dateLabel.text = review.displayDate
        cell.reviewLabel.text = review.customerReview
        if let rating = review.rating {
            cell.ratingView.rating = CGFloat(rating)
            cell.ratingView.isEnabled = false
            cell.ratingView.setNeedsDisplay()

        }
        return cell
  }
    
}


extension ReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if reviews.count == 1 {
            let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        }
        else {
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
    
    
}
