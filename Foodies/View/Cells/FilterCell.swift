//
//  FilterCell.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell{
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var thumbImageView: UIImageView!
}


extension FilterCell: ImageFiltering {
    func set(image:UIImage, item:FilterItem) {
        if item.filter != "None" {
            let filteredImg = apply(filter: item.filter, originalImage: image)
            thumbImageView.image = filteredImg
        }
        else { thumbImageView.image = image }
        nameLabel.text = item.name
        roundedCorners()
    }
    func roundedCorners() {
        thumbImageView.layer.cornerRadius = 9
        thumbImageView.layer.masksToBounds = true
    }
}
