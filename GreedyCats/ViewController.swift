//
//  ViewController.swift
//  GreedyCats
//
//  Created by kevin14 on 15/7/20.
//  Copyright (c) 2015年 kevin14. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKScriptMessageHandler,UIGestureRecognizerDelegate{
    
    private var webView:WKWebView!
    private var menu:WKWebView!
    private var menuShown = false
    private let SCALE_NUM:CGFloat = 0.6
    private let TRANSLATE_NUM:CGFloat = 1.1
    private let DURATION_NUM = 0.2
    private var fakeView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
        self.initMenuAndHome()
    }

    func initMenuAndHome(){
        
        var contentController = WKUserContentController()
        contentController.addScriptMessageHandler(self, name: "show")
        contentController.addScriptMessageHandler(self, name: "jump")
        contentController.addScriptMessageHandler(self, name: "back")
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        webView = WKWebView(frame: self.view.frame, configuration: config)
        var url = NSURL(string:Config.HOMEPAGE)
        var req = NSURLRequest(URL:url!)
        webView.loadRequest(req)
        
        menu = WKWebView(frame: CGRectMake(0, -20, self.view.frame.width, self.view.frame.height+20),configuration: config)
        var menuUrl = NSURL(string:Config.MENUPAGE)
        var menuReq = NSURLRequest(URL:menuUrl!)
        menu.loadRequest(menuReq)
        
        self.view.addSubview(menu)
        self.view.addSubview(webView)
        
        //添加一个虚拟的uiview用来返回首页
        fakeView = UIView(frame: CGRect(x: self.view.frame.width/TRANSLATE_NUM - self.view.frame.width * (1-SCALE_NUM) / 2, y: (self.view.frame.height * (1-SCALE_NUM))/2, width: self.view.frame.width * SCALE_NUM, height: self.view.frame.height * SCALE_NUM))
        fakeView.hidden = true
        self.view.addSubview(fakeView)
        var tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: "fakeViewClick")
        fakeView.addGestureRecognizer(tapGesture)
    }
    
    func fakeViewClick(){
        if self.menuShown {
            self.hideMenu()
        }
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name{
            case "show":
                self.showView(message.body as! NSDictionary)
                break
            case "jump":
                self.goPage(message.body as! NSDictionary)
                break
            case "back":
                self.goPage(message.body as! NSDictionary)
                break
            default:
                break
        }
    }
    
    private func hideMenu(){
        var transform:CGAffineTransform = CGAffineTransformMakeScale(1, 1)
        transform = CGAffineTransformTranslate(transform, 0, 0)
        UIView.animateWithDuration(DURATION_NUM, animations: {
            self.webView.transform = transform
            }, completion:{(complete: Bool) in
                self.menuShown = false
                self.fakeView.hidden = true
        })
    }

    private func showMenu(){
        var transform:CGAffineTransform = CGAffineTransformMakeScale(SCALE_NUM, SCALE_NUM)
        transform = CGAffineTransformTranslate(transform, self.view.frame.width/TRANSLATE_NUM, 0)

        UIView.animateWithDuration(DURATION_NUM, animations: {
            self.webView.transform = transform
            }, completion:{(complete: Bool) in
            self.menuShown = true
            self.fakeView.hidden = false
        })
    }
    
    private func goPage(param:NSDictionary){
        if let page:String = param.valueForKey("page") as? String{
            let otherView = self.storyboard?.instantiateViewControllerWithIdentifier("OtherViewController") as! OtherViewController
            otherView.pageUrl = Config.HOST + page
            if let params = param.valueForKey("params") as? NSDictionary{
                otherView.params = params
            }
            self.navigationController?.pushViewController(otherView, animated: true)
        }
    }
    
    private func showView(param:NSDictionary){
        if let page:String = param.valueForKey("page") as? String{
            switch page{
                case "menu":
                    self.showMenu()
                    break
                default:
                    break
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

