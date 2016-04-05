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
        
        let userAnalysisController = self.storyboard?.instantiateViewControllerWithIdentifier("user_main_analysis_scren") as! ViewController
        self.navigationController?.pushViewController(userAnalysisController, animated: true)

        
        
//        let login = FBSDKLoginManager()
//        
//        login.logInWithReadPermissions(["public_profile"], fromViewController: self) { (loginResult : FBSDKLoginManagerLoginResult!, error : NSError!) in
//            
//            if error != nil {
//                
//            }
//            else if loginResult.isCancelled {
//                
//            }
//            else{
//                
//            
//                
////                var user = User()
////                
////                //Test code to push token to the server..
////                user.fbToken = loginResult.token.tokenString
////                
////                UhoServer.createUser(user, completionHandler: { (user, error) in
////                    print("Login Success")
////                })
//                
//                
//            }
//        }
        
    }

    
}