//
//  SettingsViewController.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class SettingsViewController : UIViewController {
    
    @IBOutlet weak var monitoringSwitch : UISwitch?
    @IBOutlet weak var pushNotificationsSwitch : UISwitch?
    @IBOutlet weak var angerToleranceSlider : UISlider?
    @IBOutlet weak var disgustToleranceSlider : UISlider?
    @IBOutlet weak var sadnessToleranceSlider : UISlider?
    
    var appSettings = AppSettings()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fontColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!, NSForegroundColorAttributeName : fontColor]
        
        self.title = "Settings"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: self, action: #selector(SettingsViewController.goBack(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        
        refreshScreen()
        
    }
    
    func refreshScreen(){
        
        self.monitoringSwitch?.setOn(appSettings.monitoring, animated: false)
        self.pushNotificationsSwitch?.setOn(appSettings.pushNotifications, animated: false)
        self.angerToleranceSlider?.setValue(appSettings.angerTolerance, animated: false)
        self.disgustToleranceSlider?.setValue(appSettings.disgustTolerance, animated: false)
        self.sadnessToleranceSlider?.setValue(appSettings.sadnessTolerance, animated: false)
    }
    
    @IBAction func save(sender :AnyObject){
        
        appSettings.angerTolerance = (self.angerToleranceSlider?.value)!
        appSettings.sadnessTolerance = (self.angerToleranceSlider?.value)!
        appSettings.disgustTolerance = (self.disgustToleranceSlider?.value)!
        appSettings.monitoring = (self.monitoringSwitch?.on)!
        appSettings.pushNotifications = (self.pushNotificationsSwitch?.on)!
        
        appSettings.save()
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func goBack(sender : AnyObject ){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}