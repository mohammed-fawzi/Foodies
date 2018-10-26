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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingView.rating)
        print(titleTextField.text as Any)
        print(nameTextField.text as Any)
        print(ReviewTextView.text)
        dismiss(animated: true, completion: nil)
    }

}
