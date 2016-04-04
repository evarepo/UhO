//
//  PostAnalysisDataSource.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostAnalysisDataSource : NSObject, UITableViewDataSource{
    
    var analysisKeys:Array<String> = ["Picture", "Language"];
    var analysis:[String:Array<String>] = [
        "Picture" : [
            "Seems to contain Alchohol and Nudity",
            "Projects a party-animal personality",
            "Projects a party-animal personality",
            "Projects a party-animal personality"
        ],
        "Language" : [ "Seems to use foul language"]
    ]
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return analysisKeys.count
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let analysisContentKey = analysisKeys[section] 
        let analysisArray = analysis[analysisContentKey]
        
        if (analysisArray == nil ){
            return 0;
        }
        
        return analysisArray!.count;
        
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCellWithIdentifier("analysis_cell", forIndexPath: indexPath)
        
        let analysisLabel = tableCell.viewWithTag(22) as! UILabel
        
        let key = analysisKeys[indexPath.section];
        let analysisArray  = analysis[key]
        analysisLabel.text = analysisArray![indexPath.row]
        
        return tableCell
        
    }
    
    func titleForHeaderInSection(section : Int ) -> String {
        return analysisKeys[section]
    }
    
    

}