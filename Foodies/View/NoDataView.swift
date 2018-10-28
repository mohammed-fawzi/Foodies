//
//  NoDataView.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/25/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    var view: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // use to instantiate in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    // use to instantiate in storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadViewFromNib()
    }
   
  
    
    func loadViewFromNib(){
        Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    func set(description: String) {
        descriptionLabel.text = description
    }
}
