//
//  ViewController.swift
//  转场
//
//  Created by Alan on 16/6/6.
//  Copyright © 2016年 Xuyunfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn2: UIButton!
    lazy var presentManager:PresentManager = {
        let PMgr = PresentManager()
        return PMgr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "aa"
        self.view.backgroundColor = UIColor.redColor()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.ispresentFunc), name: PresentManagerDidPresent, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.isDismissFunc), name: PresentManagerDidDismiss, object: presentManager)
    }
    func ispresentFunc()  {
        print("ispresentFunc")
    }
    func isDismissFunc()  {
        print("isDismissFunc")
    }
    @IBAction func btnClick(sender: UIButton) {
        print("suibian")
        let neextvc = NextVC()
        //自定义转场动画
        
        //设置转场代理
        neextvc.transitioningDelegate = presentManager
        //动画样式
        neextvc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        //
        
        presentViewController(neextvc, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

