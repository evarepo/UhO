//
//  SocialNetworkController.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation
import UIKit

import FBSDKLoginKit

class SocialNetworkController : UIViewController{
    
    @IBOutlet weak var fbLoginButton : FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SDK version \(FBSDKSettings .sdkVersion())")

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func facebookTap(sender : AnyObject? ){
        if ((FBSDKAccessToken.currentAccessToken()) != nil){
            // Token is already available.
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let deviceTokenString = userDefaults.valueForKey("deviceToken")
            
            let user = User()
            user.fbToken = FBSDKAccessToken.currentAccessToken().tokenString
            
            if(deviceTokenString != nil){
                user.pushToken = deviceTokenString as! String;
            }else{
                user.pushToken = "abcndjd"
            }
            
            UhoServer.createUser(user, completionHandler: { (user, error) in
                print("Login Success")
                self.navigateUserToAnalysisViewOnSuccess(user.userId)
            })

        }else{
            // Token is not available
            let login = FBSDKLoginManager()
            login.logInWithReadPermissions(["public_profile"], fromViewController: self) { (loginResult : FBSDKLoginManagerLoginResult!, error : NSError!) in
                
                if error != nil {
                    print(error)
                }
                else if loginResult.isCancelled {
                    
                }
                else{
                    
                    print(loginResult.token.tokenString)
                    
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
                        self.navigateUserToAnalysisViewOnSuccess(user.userId)
                    })
                }
            }
        }
    }
    
    func navigateUserToAnalysisViewOnSuccess(userId:String){
        let userAnalysisController = self.storyboard?.instantiateViewControllerWithIdentifier("user_main_analysis_scren") as! ViewController
        userAnalysisController.userId = userId
        
        // save user id
        ///////////////////////////////////////////////////////
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(userId, forKey: "userId")
        userDefaults.setObject("1", forKey: "socialNetworkLoginStatus")
        userDefaults.synchronize()
        ///////////////////////////////////////////////////////
        
        self.navigationController?.pushViewController(userAnalysisController, animated: true)
    }
    
}