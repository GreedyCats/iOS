//
//  ViewController.swift
//  GreedyCats
//
//  Created by kevin14 on 15/7/20.
//  Copyright (c) 2015年 kevin14. All rights reserved.
//

import UIKit
import WebKit

class OtherViewController: UIViewController,WKScriptMessageHandler,WKUIDelegate{
    
    private var webView:WKWebView!
    var params:NSDictionary?
    var pageUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initWebView()
    }
    
    func initWebView(){
        var contentController = WKUserContentController()
        contentController.addScriptMessageHandler(self, name: "show")
        contentController.addScriptMessageHandler(self, name: "jump")
        contentController.addScriptMessageHandler(self, name: "back")
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: CGRectMake(0, -20, self.view.frame.width, self.view.frame.height+20), configuration: config)
        var url = NSURL(string:pageUrl!)

        var req = NSURLRequest(URL:url!)
        webView.loadRequest(req)
        
        self.view.addSubview(webView)
        
    }
    
    private func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func goPage(param:NSDictionary){
        if let page:NSString = param.valueForKey("page") as? NSString{
            let otherView = self.storyboard?.instantiateViewControllerWithIdentifier("OtherViewController") as! OtherViewController
            if let params = param.valueForKey("params") as? NSDictionary{
                otherView.params = params
            }
            self.navigationController?.pushViewController(otherView, animated: true)
        }
    }
    
    private func showView(param:NSDictionary){
        if let page:NSString = param.valueForKey("page") as? NSString{
            switch page{
            case "menu":

                break
            default:
                break
            }
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
            self.goBack()
            break
        default:
            break
        }
    }
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        println("alert")
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
        println("confirm")
    }
}

