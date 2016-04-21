//
//  ViewController.swift
//  Uho
//
//  Created by Bharath Booshan on 3/26/16.
//  Copyright © 2016 Feather Touch. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, XYPieChartDataSource, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    
    let values:Array<CGFloat> = [22.0,18.0,35.0,25.0];
    var colors:Array<UIColor> = Array();
    var postReport = PostReport()
    var appSettings = AppSettings()
    var userDetails = UserDetails()
    var userId:String?
    var isNavigationRootScreen:Bool?
    
    @IBOutlet weak var viewNoDataAvailable: UIView!
    @IBOutlet var piechart : XYPieChart?
    @IBOutlet var commentFillView : PercentageFillCircleView?
    @IBOutlet var picturesFillView : PercentageFillCircleView?
    @IBOutlet var videoFillView : PercentageFillCircleView?
    
    //MARK: -- View Life Cycle Delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        piechart?.dataSource = self
        piechart?.labelColor = UIColor.blackColor()
        
        colors.append(UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 97.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 91.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 77.0/255.0, green: 136.0/255.0, blue: 199.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 255.0/255.0, green: 126.0/255.0, blue: 125.0/255.0, alpha: 1.0))
        
        setupScreen()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let fontColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!, NSForegroundColorAttributeName : fontColor]

        //Loader setup
        appLoaderSetup()

        //get user detail from server
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            self.apiCallToGetUserDetails()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK:-- XYPieChart Delegate/Data Source
    //- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
    //- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
    
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
       return postReport.totalComponentsInPerceivedAsField()
    }
    
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
        return postReport.valueOfComponentAsPerceivedAsField(Int(index));
    }
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
        return colors[Int(index%4)]
    }
    
    //MARK:-- User Custom Methods
    func setupScreen(){
        self.title = "Uh O!"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Gotham-Bold", size: 21)!]
        
        if((self.isNavigationRootScreen) == nil){
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: self, action: #selector(ViewController.goBack(_:)))
        }
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .Plain, target: self, action: #selector(ViewController.showSettings(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 48.0/255.0, green: 53.0/255.0, blue: 126.0/255.0, alpha: 1.0)
    }
    
    func appLoaderSetup(){
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show()
    }
    
    func showSettings(sender : AnyObject ){
        let settingsController = self.storyboard?.instantiateViewControllerWithIdentifier("settings_controller") as! SettingsViewController
        settingsController.userDetails = self.userDetails
        self.navigationController?.pushViewController(settingsController, animated: true)
        
    }
    
    func goBack(sender : AnyObject ){
        
        if((pageViewController) != nil){
            pageViewController?.view.removeFromSuperview()
            pageViewController!.removeFromParentViewController()
            pageViewController = nil
        }else{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //MARK:-- API Calling and Response Handling
    func apiCallToGetUserDetails(){
        
        UhoServer.getUserDetails(userId!) { (userDetailedInfo, error) in
            print(userDetailedInfo)
            self.userDetails = userDetailedInfo
            // Update UI with live data
            if(userDetailedInfo.userAnalysis != nil){
                let posSplit = userDetailedInfo.userAnalysis!.valueForKey("posSplit") as! CGFloat
                let negSplit = userDetailedInfo.userAnalysis!.valueForKey("negSplit") as! CGFloat
                self.postReport.perceivedAs = [posSplit,negSplit]
                self.piechart?.reloadData()
                
                self.postReport.negativePerceptionFromComments = userDetailedInfo.userAnalysis!.valueForKey("negCommentsSplit") as? CGFloat
                self.postReport.negativePerceptionFromPhotos = userDetailedInfo.userAnalysis!.valueForKey("negPhotosSplit") as? CGFloat
                self.postReport.negativePerceptionFromVideos = userDetailedInfo.userAnalysis!.valueForKey("negVideoSplit") as? CGFloat
                
                self.commentFillView?.percentage = self.postReport.negativePerceptionFromComments!
                self.picturesFillView?.percentage = self.postReport.negativePerceptionFromPhotos!
                self.videoFillView?.percentage = self.postReport.negativePerceptionFromVideos!
                
                // Populate app settings
                self.appSettings.angerTolerance = userDetailedInfo.userInfo?.valueForKey("settings")?.valueForKey("anger") as! Float
                self.appSettings.foulLanguage = userDetailedInfo.userInfo?.valueForKey("settings")?.valueForKey("foul language") as! Float
                self.appSettings.politicalCorrectness = userDetailedInfo.userInfo?.valueForKey("settings")?.valueForKey("political correctness") as! Float
                self.appSettings.partying = userDetailedInfo.userInfo?.valueForKey("settings")?.valueForKey("partying") as! Float
                self.appSettings.monitoring = userDetailedInfo.userInfo?.valueForKey("settings")?.valueForKey("monitoring") as! Bool
                self.appSettings.save()
                
                if(posSplit == 0 && negSplit == 0 && self.postReport.negativePerceptionFromComments == 0.0 && self.postReport.negativePerceptionFromPhotos == 0.0 && self.postReport.negativePerceptionFromVideos == 0.0){
                    self.viewNoDataAvailable.hidden = false
                    self.view.bringSubviewToFront(self.viewNoDataAvailable)
                }
            }else{
                self.viewNoDataAvailable.hidden = false
                self.view.bringSubviewToFront(self.viewNoDataAvailable)
            }
        }
        dispatch_async(dispatch_get_main_queue()) {
            PKHUD.sharedHUD.hide(animated: true, completion: nil)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        var index = (viewController as! PostDetailAnalysisController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index);
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        
        var index = (viewController as! PostDetailAnalysisController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++

        
        return viewControllerAtIndex(index);
    }
    
    @IBAction func fixItTap(sender : AnyObject? ){
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: PostDetailAnalysisController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index: Int) -> PostDetailAnalysisController?
    {
        if self.userDetails.userAnalysis!.count == 0 || index >= self.userDetails.userAnalysis!.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        //let pageContentViewController = PostDetailAnalysisController()
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pageContentViewController : PostDetailAnalysisController = storyboard.instantiateViewControllerWithIdentifier("PostDetailAnalysisController") as! PostDetailAnalysisController

        
        let postData = self.userDetails.userAnalysis!.valueForKey("analysis") as? NSDictionary
        
        var postDic = NSDictionary()
        let postAllKey = postData?.allKeys
        var keyValue = String()
        
        if((postData) != nil && index < postData?.count){
            keyValue = postAllKey![index] as! String
            
            postDic = postData!.objectForKey(keyValue) as! NSDictionary
            
            pageContentViewController.postServerData = postDic
            pageContentViewController.pageIndex = index
        }
        
        currentIndex = index
        
        return pageContentViewController
    }
}


