//
//  MypreVC.swift
//  转场
//
//  Created by Alan on 16/6/6.
//  Copyright © 2016年 Xuyunfan. All rights reserved.
//

import UIKit
/*
 1.如果不自定义转场modal出来的控制器会移除原有的控制器
 2.如果自定义转场modal出来的控制器不会移除原有的控制器
 3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
 4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
 5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
 6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
 */
class MypreVC: UIPresentationController  {
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews(){
        // 设置弹出视图的尺寸
    presentedView()?.frame = CGRect.init(x: 0, y: 64, width: 200, height: (containerView?.frame.size.height)!)
          // 添加透明button背景
        xyf = UIButton()
        xyf!.frame = UIScreen.mainScreen().bounds
    containerView?.insertSubview(xyf!, atIndex: 0)
        xyf?.tag = 66
        xyf?.addTarget(self, action: #selector(MypreVC.funcyion2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
    }
    private var xyf:UIButton?

    func funcyion2(sender:UIButton)  {
        print(sender.tag)
        print("dismiss")
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
