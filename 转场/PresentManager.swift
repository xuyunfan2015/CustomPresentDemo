//
//  PresentManager.swift
//  转场
//
//  Created by Alan on 16/6/12.
//  Copyright © 2016年 Xuyunfan. All rights reserved.
//

import UIKit
let PresentManagerDidPresent = "PresentManagerDidPresent"
let PresentManagerDidDismiss = "PresentManagerDidDismiss"


class PresentManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    // 该方法用于返回一个负责转场动画的对象
    // 可以在该对象中控制弹出视图的尺寸等
    var isPresent :Bool = true
    //MARK:-UIViewControllerTransitioningDelegate

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        return MypreVC(presentedViewController: presented, presentingViewController: presenting)
    }
    // 该方法用于返回一个负责转场如何消失的对象
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        NSNotificationCenter.defaultCenter().postNotificationName(PresentManagerDidDismiss, object: self)
        return self
        
    }
    // 该方法用于返回一个负责转场如何出现的对象
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        NSNotificationCenter.defaultCenter().postNotificationName(PresentManagerDidPresent, object: self)
        return self
    }
    
    
    //MARK:-UIViewControllerAnimatedTransitioning
    // 告诉系统展现和消失的动画时长
    // 暂时用不上
    //这个方法没什么作用
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 50
    }
    // 专门用于管理modal如何展现和消失的, 无论是展现还是消失都会调用该方法
    /*
     注意点: 只要我们实现了这个代理方法, 那么系统就不会再有默认的动画了
     也就是说默认的modal从下至上的移动系统不帮再帮我们添加了, 所有的动画操作都需要我们自己实现, 包括需要展现的视图也需要我们自己添加到容器视图上(containerView)
     */
    // transitionContext: 所有动画需要的东西都保存在上下文中, 换而言之就是可以通过transitionContext获取到我们想要的东西
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        // 0.判断当前是展现还是消失
        if isPresent {
            self.animateTransitionIsPresent(transitionContext)
                    }
        else{
            //dismiss
            // 消失
            self.animateTransitionIsDismiss(transitionContext)
            }
    }
    //present时候的动画
    func animateTransitionIsPresent(transitionContext: UIViewControllerContextTransitioning)  {
         // 通过ToViewKey取出的就是toVC对应的view
        guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else{
            return
        }
        // 2.将需要弹出的视图添加到containerView上
        transitionContext.containerView()?.addSubview(toView)
        
        // 3.执行动画
        
        toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
        // 设置锚点
        toView.layer.anchorPoint = CGPoint (x: 0.5, y: 0)
        UIView.animateWithDuration(2, animations: {
            toView.transform = CGAffineTransformIdentity
        }) { (_) in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        }

    }
    //dismiss时候的动画
    func animateTransitionIsDismiss(transitionContext: UIViewControllerContextTransitioning)  {
        //dismiss
        // 消失
        // 1.拿到需要消失的视图
        
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else{
            return
        }
        //transitionContext.containerView()?.addSubview(toView)
        // 2.执行动画让视图消失
        
        fromView.transform = CGAffineTransformIdentity
        fromView.layer.anchorPoint = CGPoint (x: 0.5, y: 0)
        UIView.animateWithDuration(2, animations: {
            // 突然消失的原因: CGFloat不准确, 导致无法执行动画, 遇到这样的问题只需要将CGFloat的值设置为一个很小的值即可
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.0001)
        }) { (_) in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        }
        
        

    }

    

}
