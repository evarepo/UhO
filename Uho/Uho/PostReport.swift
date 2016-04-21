//
//  PostReport.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostReport {
    
    var perceivedAs:Array<CGFloat>!
    var negativePerceptionFromComments:CGFloat?
    var negativePerceptionFromPhotos:CGFloat?
    var negativePerceptionFromVideos:CGFloat?
    /*
 
      "post_report" : {
            "posPosts" : 18,
            "negativePosts : 0,
            "negComments"
            "negPhotos":
            "negVideos"
            "detailed_analysis" : [
     
                    "image" : url
                    "post_analysis" : {
                            "Picture" : []
                            "Languages" : []
                        }
                    "post_comments": [
     
                    ]
        
     
     
                ]
     
      }
 
  */
    
//    // Array of PostDetailAnayliss
//        - postAnalysis
//        - postcomments
    var postAnalysis = PostAnalysisDataSource()
    var postcomments = PostComments()
    
    func totalComponentsInPerceivedAsField() -> UInt{
        if(perceivedAs != nil){
            return UInt(perceivedAs!.count)
        }
        else{
            return 0
        }
    }
    
    func valueOfComponentAsPerceivedAsField(index : Int ) -> CGFloat{
        return perceivedAs![ index ]
    }
    
}