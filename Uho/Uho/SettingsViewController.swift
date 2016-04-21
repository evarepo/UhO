//
//  SettingsViewController.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

import FBSDKLoginKit

class SettingsViewController : UIViewController {
    
    var userDetails = UserDetails()
    @IBOutlet weak var monitoringSwitch : UISwitch?
    @IBOutlet weak var pushNotificationsSwitch : UISwitch?
    @IBOutlet weak var angerToleranceSlider : UISlider?
    @IBOutlet weak var foulLanguageSlider: UISlider!
    @IBOutlet weak var politicalCorrectnessSlider: UISlider!
    @IBOutlet weak var partyingSlider: UISlider!
    
    @IBOutlet weak var toleranceLevelScrollView: UIScrollView!
    @IBOutlet weak var toleranceLevelView: UIView!
    //@IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var appSettings = AppSettings()
    
    //MARK:-- View Life Cycle Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fontColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!, NSForegroundColorAttributeName : fontColor]
        
        self.title = "Settings"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: self, action: #selector(SettingsViewController.goBack(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        
        //self.toleranceLevelView.frame = CGRectMake(0, 0, self.toleranceLevelView.frame.size.width, 350)
        
        refreshScreen()
    }
    
    //MARK:-- User Custom Methods
    func refreshScreen(){
        
        self.monitoringSwitch?.setOn(appSettings.monitoring, animated: false)
        self.pushNotificationsSwitch?.setOn(appSettings.pushNotifications, animated: false)
        self.angerToleranceSlider?.setValue(appSettings.angerTolerance, animated: false)
        self.foulLanguageSlider?.setValue(appSettings.foulLanguage, animated: false)
        self.politicalCorrectnessSlider?.setValue(appSettings.politicalCorrectness, animated: false)
        self.partyingSlider?.setValue(appSettings.partying, animated: false)
    }
    
    //MARK:-- Button Actions
    @IBAction func save(sender :AnyObject){
        print(userDetails.userInfo)
        
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show()

        //update user settings to server
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            self.updateAppSetting()

        })
    }
    
    func goBack(sender : AnyObject ){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func sliderVaueChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        if(slider.tag == 1){
            // Anger slider value handing
        }else if(slider.tag == 2){
            // Foul Language slider value handing

        }else if(slider.tag == 3){
            // Political Correctness slider value handing

        }else{
            // Partying slider value handing
        }
        
    }
    
    //MARK:-- API Calling and Response Handling
    func updateAppSetting(){
        let userInfo = self.userDetails.userInfo?.mutableCopy() as! NSDictionary
        let settingDict = userInfo.valueForKey("settings")?.mutableCopy()
        
        settingDict?.setValue(Int((self.angerToleranceSlider?.value)!), forKey: "anger")
        settingDict?.setValue(Int((self.foulLanguageSlider?.value)!), forKey: "foul language")
        settingDict?.setValue(Int((self.politicalCorrectnessSlider?.value)!), forKey: "political correctness")
        settingDict?.setValue(Int((self.partyingSlider?.value)!), forKey: "partying")
        print(self.monitoringSwitch?.on)
        if((self.monitoringSwitch?.on) == true){
            settingDict?.setValue("1", forKey: "monitoring")
        }
        else{
            settingDict?.setValue("0", forKey: "monitoring")
        }
        userInfo.setValue(settingDict, forKey: "settings")
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if((self.pushNotificationsSwitch?.on) == true){
            userInfo.setValue(appDelegate.deviceToken, forKey: "pushToken")
        }
        else{
            userInfo.setValue("", forKey: "pushToken")
        }
        
        self.userDetails.userInfo = userInfo
        print(self.userDetails.userInfo)
        
        UhoServer.updateUser(self.userDetails.userInfo!) { (response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                PKHUD.sharedHUD.hide(animated: true, completion: nil)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }

    }
    
    @IBAction func refreshButtoTap(sender : AnyObject? ){
        
        //TODO: update functionality as per different login option introduce
        // Refresh facebook Token and update token on server
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile"], fromViewController: self) { (loginResult : FBSDKLoginManagerLoginResult!, error : NSError!) in
            
            if error != nil {
                print(error)
            }
            else if loginResult.isCancelled {
                
            }
            else{
                
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let deviceTokenString = userDefaults.valueForKey("deviceToken")
                
                let user = User()
                //Test code to push token to the server..
                user.fbToken = loginResult.token.tokenString
                
                
                if(deviceTokenString != nil){
                    user.pushToken = deviceTokenString as! String;
                }else{
                    user.pushToken = "abcndjd"
                }
                
                UhoServer.createUser(user, completionHandler: { (user, error) in
                    print("Login Success")
                    //self.navigateUserToAnalysisViewOnSuccess(user.userId)
                    
                })
            }
        }
    }
    
}