//
//  UnlimitedSlideVC.swift
//  CarouselPicture_NoLimited
//
//  Created by langyue on 15/11/19.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit


@objc protocol UnlimitedSlideVCDelegate{
    
    func backDataSourceArray()->NSMutableArray
    optional func backScrollerViewForWidthAndHeight()->CGSize
    
    
}

let kScreenWidth = UIScreen.mainScreen().bounds.size.width


@objc class UnlimitedSlideVC: UIViewController,UIScrollViewDelegate{

    var delegate : UnlimitedSlideVCDelegate!
    
    
    var leftImageView , middleImageView , rightImageView : UIImageView?
    
    var scrollerView : UIScrollView?
    
    //当前展示的图片
    var currentIndex : Int?
    //数据源
    var dataSource : NSMutableArray?
    //scrollView的宽和高
    var scrollerViewWidth : CGFloat?
    var scrollerViewHeight : CGFloat?
    
    var pageControl : UIPageControl?
    
    
    
    var isPageControl : NSNumber!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentIndex = 0
        
        self.scrollerViewWidth = kScreenWidth-20
        self.scrollerViewHeight = 300
        
        let size : CGSize = self.delegate.backScrollerViewForWidthAndHeight!()
        
        self.scrollerViewWidth = size.width
        self.scrollerViewHeight = size.height
        
        
        self.dataSource =  NSMutableArray(array: self.delegate.backDataSourceArray())
        self.configureScrollerView()
        self.configureImageView()
        
        
        if(( self.isPageControl.boolValue ) != false){
            self.configurePageController()
        }
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "letItScroll", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor.redColor()
    }
    

    
    func letItScroll(){
        
        self.scrollerView?.setContentOffset( CGPointMake(2*scrollerViewWidth!, 0), animated: true)
    }
    
    
    
    
    func configureScrollerView(){
        
        self.scrollerView = UIScrollView(frame: CGRectMake(0,0,self.scrollerViewWidth!,self.scrollerViewHeight!))
        self.scrollerView?.backgroundColor = UIColor.redColor()
        self.scrollerView?.delegate = self
        self.scrollerView?.contentSize = CGSizeMake(self.scrollerViewWidth! * 3, self.scrollerViewHeight!)
        self.scrollerView?.contentOffset = CGPointMake(self.scrollerViewWidth!, 0)
        self.scrollerView?.pagingEnabled = true
        self.scrollerView?.bounces = false
        self.view.addSubview(self.scrollerView!)
        
    }
    
    
    func configureImageView(){
        
        self.leftImageView = UIImageView(frame: CGRectMake(0, 0, self.scrollerViewWidth!, self.scrollerViewHeight!))
        
        self.middleImageView = UIImageView(frame: CGRectMake(self.scrollerViewWidth!, 0, self.scrollerViewWidth!, self.scrollerViewHeight! ));
        
        self.rightImageView = UIImageView(frame: CGRectMake(2*self.scrollerViewWidth!, 0, self.scrollerViewWidth!, self.scrollerViewHeight!));
        
        
        self.scrollerView?.showsHorizontalScrollIndicator = false
        if(self.dataSource?.count != 0){
            
            
            
            self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource?.lastObject as! String)!)
            self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource?.firstObject as! String)!)
            self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![1] as! String)!)
            
            
            
            
//            self.leftImageView?.image = UIImage(named:self.dataSource?.lastObject as! String)
//            self.middleImageView?.image = UIImage(named: self.dataSource?.firstObject as! String)
//            self.rightImageView?.image = UIImage(named: self.dataSource![1] as! String);
            
        }
        
        self.scrollerView?.addSubview(self.leftImageView!)
        self.scrollerView?.addSubview(self.middleImageView!)
        self.scrollerView?.addSubview(self.rightImageView!)
        
    }
    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        let offset = scrollView.contentOffset.x
        
        if(self.dataSource?.count != 0){
            
            
            if(offset >= self.scrollerViewWidth!*2){
                
                scrollView.contentOffset = CGPointMake(self.scrollerViewWidth!, 0)
                self.currentIndex = self.currentIndex! + 1
                
                
                
                if(self.currentIndex == (self.dataSource?.count)! - 1){
                    
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex! - 1] as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: (self.dataSource?.firstObject)! as! String)!)
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex! - 1] as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: (self.dataSource?.firstObject)! as! String)
                    
                    
                    
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!;
                    self.currentIndex = -1
                    
                }else if(self.currentIndex == self.dataSource?.count){
                    
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource!.firstObject as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![1] as! String)!)
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource!.lastObject as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource!.firstObject as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource![1] as! String)
                    
                    
                    
                    self.pageControl?.currentPage = 0
                    self.currentIndex = 0
                    
                    
                }else if(self.currentIndex == 0){
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    
                    
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource!.lastObject as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex!+1] as! String)
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else{
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex!-1] as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex!+1] as! String)
                    
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!
                  
                }
                
            }
            
            
            
            
            
            
            
            
            
            if(offset <= 0){
                
                scrollView.contentOffset = CGPointMake(self.scrollerViewWidth!, 0);
                
                self.currentIndex = self.currentIndex! - 1
                
                if(self.currentIndex == -2 ){
                    
                    
                    
                    
                    
                    
                    
                    self.currentIndex = (self.dataSource?.count)! - 2
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource![(self.dataSource?.count)! - 1] as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: (self.dataSource?.lastObject)! as! String)
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource![(self.dataSource?.count)! - 1] as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: (self.dataSource?.lastObject)! as! String)!)
                    
                    
                    
                    
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!;
                    
                }else if(self.currentIndex == -1 ){
                    
                    self.currentIndex = (self.dataSource?.count)! - 1
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource?.firstObject as! String)!)
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex!-1] as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource?.firstObject as! String)
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else if(self.currentIndex == 0){
                    
                    
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource!.lastObject as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex!+1] as! String)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else{
                    
                    self.leftImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.setImageWithURL(NSURL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
//                    self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex!-1] as! String)
//                    self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex!] as! String)
//                    self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex!+1] as! String)
                    
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }
                
            }

            
            
        }
        
        
        
        
        
        
    }
    
    
    
    func configurePageController() {
        
        self.pageControl = UIPageControl(frame: CGRectMake(kScreenWidth/2-60,self.scrollerViewHeight! - 20,120,20)) //self.scrollerViewWidth!
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.userInteractionEnabled = false
        self.view.addSubview(self.pageControl!)
        
        
        
    }
    
    
    
    
    func backCurrentClickPicture()-> NSInteger{
    
        return (self.pageControl?.currentPage)!
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
