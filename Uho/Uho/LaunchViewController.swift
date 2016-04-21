//
//  LaunchViewController.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation


class LaunchViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func startTap(sender : AnyObject ){
        NSNotificationCenter.defaultCenter().postNotificationName(AskPushNotificationKey, object: nil)
        
        // save first launch status
        ///////////////////////////////////////////////////////
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject("1", forKey: "appFirstLaunchStatus")
        userDefaults.synchronize()
        ///////////////////////////////////////////////////////
    }
    
}