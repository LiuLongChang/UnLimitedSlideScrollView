//
//  ViewController.swift
//  UnLimitedSlideScrollView
//
//  Created by langyue on 15/11/25.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit


let screenWidth =  UIScreen.mainScreen().bounds.size.width

class ViewController: UIViewController,UnlimitedSlideVCDelegate {
    
    
    var scrollViewVC : UnlimitedSlideVC!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        scrollViewVC = UnlimitedSlideVC()
        scrollViewVC.delegate = self
        scrollViewVC.isPageControl = NSNumber(bool: true)
        self.addChildViewController(scrollViewVC)
        self.view.addSubview(scrollViewVC.view)
        
        scrollViewVC.view.frame = CGRectMake(10, 50, screenWidth-20, 260);
        
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTapAction:")
        scrollViewVC.view.addGestureRecognizer(tap)
        
        
        
    }
    
    
    
    func backDataSourceArray() -> NSMutableArray {
        return ["http://img0.bdstatic.com/img/image/shouye/sheying1124.jpg","http://img0.bdstatic.com/img/image/shouye/bizhi1124.jpg","http://img0.bdstatic.com/img/image/shouye/mingxing1124.jpg","http://img0.bdstatic.com/img/image/shouye/chongwu1124.jpg","http://img0.bdstatic.com/img/image/shouye/dongman1124.jpg"];
    }
    
    
    func backScrollerViewForWidthAndHeight() -> CGSize {
        return CGSizeMake(screenWidth-20, 260)
    }
    
    
    func handleTapAction(tap:UITapGestureRecognizer)->Void{
        
        let page : Int = scrollViewVC.backCurrentClickPicture()
        print("%d",page)
    
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

