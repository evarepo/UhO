//
//  UhoServer.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation
import Alamofire

class UhoServer {
    
    
    class func createUser(inputUser : User , completionHandler: ( user : User! , error : NSError! ) -> Void ){
        
        
        print("UHO Server")
        print(inputUser.dictionaryRepresentation())
        Alamofire.request(.POST, "http://52.91.235.124:8090/user", parameters: inputUser.dictionaryRepresentation(), encoding: .JSON, headers: nil ).responseJSON { response  in
            
            if let json = response.result.value {
                print (json)
                inputUser.userId = json.valueForKey("result") as! String
                completionHandler(user: inputUser, error: nil)
            }
        }
        
    }

    class func getUserDetails(userId : String , completionHandler: ( userDetailedInfo : UserDetails , error : NSError! ) -> Void ){
        
        let postEndpoint: String = String(format:"http://52.91.235.124:8090/user?id=%@",userId)
        //let postEndpoint: String = String(format:"http://52.91.235.124:8090/user?id=5705c8783d1d4020d0a5e1ae")
        
        
        Alamofire.request(.GET, postEndpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let json = response.result.value {
                    print (json)
                    let responseData = json as! NSDictionary
                    let code = responseData.valueForKey("code") as! Int
                    if(code == 200){
                        //Success
                        let userDetails = UserDetails()
                        userDetails.userInfo = responseData.valueForKey("result")!.valueForKey("user") as? NSDictionary
                        userDetails.userAnalysis = responseData.valueForKey("result")!.valueForKey("analysis") as? NSDictionary
                            completionHandler(userDetailedInfo:userDetails, error: nil)
                    }
                }
        }
    }
    
    class func updateUser(userDetails : NSDictionary , completionHandler: ( response : NSDictionary , error : NSError! ) -> Void ){
        
        print(userDetails)
        print(userDetails as? [String : AnyObject])
        print("UHO Server")
        Alamofire.request(.POST, "http://52.91.235.124:8090/user", parameters: userDetails as? [String : AnyObject], encoding: .JSON, headers: nil ).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
            }
            
            if let json = response.result.value {
                print (json)
                let responseData = json as! NSDictionary
                completionHandler(response:responseData, error: nil)
            }
        }
    }
}