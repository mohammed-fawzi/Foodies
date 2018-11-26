//
//  ExploreCell.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/14/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
    }
    
    
}
