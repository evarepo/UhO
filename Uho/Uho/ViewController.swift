//
//  ViewController.swift
//  Uho
//
//  Created by Bharath Booshan on 3/26/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XYPieChartDataSource {

    let values:Array<CGFloat> = [22.0,18.0,35.0,25.0];
    var colors:Array<UIColor> = Array();
    
    @IBOutlet var piechart : XYPieChart?
    @IBOutlet var commentFillView : PercentageFillCircleView?
    @IBOutlet var picturesFillView : PercentageFillCircleView?
    @IBOutlet var videoFillView : PercentageFillCircleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        piechart?.dataSource = self
        piechart?.labelColor = UIColor.blackColor()
        
        colors.append(UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 97.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 91.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 77.0/255.0, green: 136.0/255.0, blue: 199.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 255.0/255.0, green: 126.0/255.0, blue: 125.0/255.0, alpha: 1.0))
        
        setupScreen()
       


        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
    //- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
    
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
       return UInt(values.count)
    }
    
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
        return values[Int(index)];
    }
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
        return colors[Int(index%4)]
    }
    
    func setupScreen(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
    }
    
    func refreshScreen(){
        piechart?.reloadData()
        self.commentFillView?.percentage = 0.3
        self.picturesFillView?.percentage = 0.5
        self.videoFillView?.percentage = 0.7
    }

}

