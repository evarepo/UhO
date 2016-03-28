//
//  PercentageFillCircleView.swift
//  Uho
//
//  Created by Bharath Booshan on 3/26/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation
import QuartzCore

class PercentageFillCircleView : UIView {
    
    private let circleLayer = CAShapeLayer()
    private let circleFillLayer = CAShapeLayer()
    
    @IBOutlet var percentageTitle : UILabel?
    @IBOutlet var subTitle : UILabel?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    var percentage:CGFloat = 0.0 {
        didSet{
            updateFillLayerPosition()
        }
    }
    
    func setupLayer(){
        
        self.backgroundColor = UIColor.clearColor()
        
        circleLayer.fillColor = UIColor.clearColor().CGColor
        let borderGrayScale:CGFloat = 181.0/255.0
        circleLayer.borderColor = UIColor(red: borderGrayScale, green: borderGrayScale, blue: borderGrayScale, alpha: 1.0).CGColor
        circleLayer.borderColor = UIColor.grayColor().CGColor
        circleLayer.borderWidth = CGFloat(1.0);
        circleLayer.allowsEdgeAntialiasing = true
        circleLayer.masksToBounds = true
        
        let grayColor:CGFloat = 245.0/255.0
        
        circleFillLayer.backgroundColor = UIColor(red: grayColor, green: grayColor, blue: grayColor, alpha: 1.0).CGColor
        circleLayer.addSublayer(circleFillLayer)
        
        
        self.layer.addSublayer(circleLayer)
        circleLayer.zPosition = -1.0

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = self.bounds
        circleLayer.cornerRadius = ceil(self.bounds.size.width / 2.0)
        circleFillLayer.frame = circleLayer.bounds
        
        updateFillLayerPosition()
    }
    
    func updateFillLayerPosition(){
        var fillRect = circleFillLayer.frame;
        let lowPosition = self.bounds.size.height
        let finalPosition = ceil(lowPosition - ( self.percentage * (self.bounds.size.height)))
        fillRect.origin.y = CGFloat(finalPosition)
        circleFillLayer.frame = fillRect
    }
    
    
    
}