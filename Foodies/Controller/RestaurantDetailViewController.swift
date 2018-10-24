//
//  RestaurantDetailViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/24/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    var resturant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        dump(resturant as Any)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // MARK: - Table view delegate

}
