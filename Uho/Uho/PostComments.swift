//
//  PostComments.swift
//  Uho
//
//  Created by Bharath Booshan on 4/4/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostComments : NSObject , UITableViewDataSource {
    
    var postComments = [
        "Sridhar: this is a big text that should reach atleast double lines \n another line",
        "Harshal : Single Line Comment"
    ]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCellWithIdentifier("comments_cell", forIndexPath: indexPath)
        
        let label = tableCell.viewWithTag(22) as! UILabel
        
        label.text = postComments[indexPath.row]
        
        return tableCell
    }
    
}