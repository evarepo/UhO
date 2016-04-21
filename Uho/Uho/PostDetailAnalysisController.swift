//
//  PostDetailAnalysisController.swift
//  Uho
//
//  Created by Bharath Booshan on 3/27/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import Foundation

class PostDetailAnalysisController : UIViewController, UITableViewDelegate {
    
    var pageIndex : Int = 0
    
    @IBOutlet weak var postImageView : UIImageView?
    @IBOutlet weak var analysisTableView : UITableView?
    @IBOutlet weak var commentsTableView : UITableView?
    
    
    var postServerData:NSDictionary?
    //var postCommentsData:[String:Array<String>]?
    //var imageUrl: String?
    
    let postAnalysisContent = PostAnalysisDataSource()
    let postComments = PostComments()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
        let nib = UINib(nibName: "TableSectionHeaderView", bundle: nil)
        
        self.analysisTableView?.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")
    
        self.analysisTableView?.separatorStyle = .None
        
        self.analysisTableView?.estimatedRowHeight = 24.0
        self.analysisTableView?.rowHeight = UITableViewAutomaticDimension
        self.analysisTableView?.dataSource = postAnalysisContent
        self.analysisTableView?.delegate = self
        
        
        self.commentsTableView?.separatorStyle = .None
        self.commentsTableView?.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 2.0, right: 0.0)
        self.commentsTableView?.estimatedRowHeight = 24.0
        self.commentsTableView?.rowHeight = UITableViewAutomaticDimension
        self.commentsTableView?.dataSource = postComments
        
        
        self.commentsTableView?.backgroundColor = self.view.backgroundColor
        self.commentsTableView?.backgroundColor = UIColor.clearColor()
        
        // configur server response in model
        //////////////////////////////////////////////////////////////////////
        let pictureCommentList:NSString = postServerData!.objectForKey("picComment") as! NSString
        
        var analysis:[String:Array<String>] = [
            "Picture" : [pictureCommentList as String]
        ]
        
        
        let postCommentList:NSString = postServerData!.objectForKey("postMsgComment") as! NSString
        
        let postComment:Array = [postCommentList as String]
        
        postAnalysisContent.analysis = analysis;
        postComments.postComments = postComment;
        
        if let checkedUrl = NSURL(string: postServerData!.objectForKey("picURL") as! String) {
            downloadImage(checkedUrl)
        }
        //////////////////////////////////////////////////////////////////////
        
    }
    
    func setupScreen(){
        
        let fontColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!, NSForegroundColorAttributeName : fontColor]
        
        self.title = "Uh O!"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: self, action: #selector(PostDetailAnalysisController.goBack(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .Plain, target: self, action: #selector(PostDetailAnalysisController.showSettings(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableSectionHeader")
        
        let header = cell as! TableSectionHeaderView
        header.titleLabel?.text = postAnalysisContent.titleForHeaderInSection(section)
        return header
    }
    
    func showSettings(sender : AnyObject ){
        
        let settingsController = self.storyboard?.instantiateViewControllerWithIdentifier("settings_controller") as! SettingsViewController
        self.navigationController?.pushViewController(settingsController, animated: true)
        
    }
    
    func goBack(sender : AnyObject ){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.postImageView!.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func editPostTap(sender : AnyObject? ){
        
        let schemeUrl: String = String(format:"fb://post/%@",postServerData!.objectForKey("postId") as! String)
        UIApplication.sharedApplication().openURL(NSURL(string: schemeUrl)!)
        
    }
    
    
}