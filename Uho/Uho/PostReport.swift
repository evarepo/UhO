//
//  PostReport.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostReport {
    
    var perceivedAs:Array<CGFloat> = [ 0.12,0.3,0.5,0.8]
    var negativePerceptionFromComments:CGFloat = 0.3
    var negativePerceptionFromPhotos:CGFloat = 0.7
    var negativePerceptionFromVideos:CGFloat = 0.45
    var postAnalysis = PostAnalysisDataSource()
    var postcomments = PostComments()
    
    
    func totalComponentsInPerceivedAsField() -> UInt{
        return UInt(perceivedAs.count)
    }
    
    func valueOfComponentAsPerceivedAsField(index : Int ) -> CGFloat{
        return perceivedAs[ index ]
    }
    
}