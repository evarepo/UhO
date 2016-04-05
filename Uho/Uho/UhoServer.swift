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
        Alamofire.request(.POST, "http://52.91.235.124:8090/user", parameters: inputUser.dictionaryRepresentation(), encoding: .JSON, headers: nil ).responseJSON { response  in
            
            if let json = response.result.value {
                print (json)
                
                completionHandler(user: nil, error: nil)
            }
        }
        
    }
    
}