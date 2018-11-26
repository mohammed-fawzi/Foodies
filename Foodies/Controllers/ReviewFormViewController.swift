//
//  ReviewFormViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ReviewTextView: UITextView!
    
    var selectedRestaurantID:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurantID as Any)
    }

   
    @IBAction func onSaveTapped(_ sender: Any) {
        var review = ReviewItem()
        review.rating = Float(ratingView.rating)
        print(ratingView.rating)
        review.title = titleTextField.text == "" ? "No Title": titleTextField.text
        review.name = nameTextField.text == "" ? "User": nameTextField.text
        review.customerReview = ReviewTextView.text == "" ? "no Review": ReviewTextView.text
        review.restaurantID = selectedRestaurantID
        let manager = CoreDataManager()
        manager.saveReview(review)
        dismiss(animated: true, completion: nil)
    }

}
