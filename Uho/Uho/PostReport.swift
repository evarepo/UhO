//
//  PostReport.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostReport {
    
    var perceivedAs:Array<CGFloat> = [ 0.7,0.3]
    var negativePerceptionFromComments:CGFloat = 0.3
    var negativePerceptionFromPhotos:CGFloat = 0.7
    var negativePerceptionFromVideos:CGFloat = 0.45
    
    
    
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
        return UInt(perceivedAs.count)
    }
    
    func valueOfComponentAsPerceivedAsField(index : Int ) -> CGFloat{
        return perceivedAs[ index ]
    }
    
}