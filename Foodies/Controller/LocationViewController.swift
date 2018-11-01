//
//  LocationViewController.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/21/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let manager = LocationDataManager()
    var selectedCity:LocationItem?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let city = selectedCity {
            title = city.full
        }
        else{title = "Choose Your City" }
        // Do any additional setup after loading the view.
    }
    
    // limit the user to select only one location
    func  set(selected cell:UITableViewCell, at indexPath: IndexPath){
        if let city = selectedCity{
            let data = manager.findLocation(by: city.city!)
            if data.isFound {
                if indexPath.row == data.position {
                    cell.accessoryType = .checkmark
                }
                else { cell.accessoryType = .none }
            }
        }
        else { cell.accessoryType = .none }
    }
    
 
}

// MARK:- tableView dataSource
extension LocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"locationCell", for: indexPath)
        
        cell.textLabel?.text = manager.locationItem(at: indexPath).full
        set(selected: cell, at: indexPath)
        
        return cell
    }
}




// MARK:- tableView delegate
extension LocationViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedCity = manager.locationItem(at: indexPath)
        title = selectedCity?.full
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
}
