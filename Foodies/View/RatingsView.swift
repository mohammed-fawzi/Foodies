//
//  RatingsView.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit

class RatingsView: UIControl {

    let imgFilledStar = #imageLiteral(resourceName: "filled-star")
    let imgHalfStar = #imageLiteral(resourceName: "half-star")
    let imgEmptyStar = #imageLiteral(resourceName: "empty-star")
    let shouldBecomeFirstResponder = true
    var rating:CGFloat = 0.0
    var totalStars = 5
    
    //required methods to draw
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.setNeedsLayout()
    }
    
    // required methods to enable touch control
    override var canBecomeFirstResponder: Bool {
        return shouldBecomeFirstResponder
    }
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if self.isEnabled {
            super.beginTracking(touch, with: event)
            if (shouldBecomeFirstResponder && self.isFirstResponder) {
                becomeFirstResponder()
            }
            handle(with: touch)
            return true
        }
        else { return false }
    }
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
        context!.fill(rect)
        let availWidth = rect.size.width
        let cellWidth = availWidth / CGFloat(totalStars)
        let starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height
        for index in 0...totalStars {
            let value = cellWidth*CGFloat(index) + cellWidth/2
            let center = CGPoint(x: value+1, y: rect.size.height/2)
            let frame = CGRect(x: center.x - starSide/2, y: center.y - starSide/2, width: starSide, height: starSide)
            let highlighted = (Float(index+1) <= ceilf(Float(self.rating)))
            if highlighted && (CGFloat(index+1) > CGFloat(self.rating)) {
                drawHalfStar(with: frame)
            } else {
                drawStar(with: frame, highlighted: highlighted)
            }
        }
    }

}


private extension RatingsView {
    
    
    func drawStar(with frame:CGRect, highlighted:Bool) {
        let image = highlighted ? imgFilledStar :imgEmptyStar
        draw(with: image, and: frame)
    }
    func drawHalfStar(with frame:CGRect) {
        draw(with: imgHalfStar, and: frame)
    }
    func draw(with image:UIImage, and frame:CGRect) {
        image.draw(in: frame)
    }
    
    func handle(with touch: UITouch) {
        let cellWidth = self.bounds.size.width / CGFloat(totalStars)
        let location = touch.location(in: self)
        var value = location.x / cellWidth
        if (value + 0.5 < CGFloat(ceilf(Float(value)))) {
            value = floor(value) + 0.5
        }
        else {
            value = CGFloat(ceilf(Float(value)))
        }
        updateRating(with: value)
    }
    
    // Update Rating
    func updateRating(with value:CGFloat) {
        if (self.rating != value && value >= 0 && value <= CGFloat(totalStars)) {
            self.rating = value
            setNeedsDisplay()
        }
    }
}
