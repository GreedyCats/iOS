//
//  ViewController.swift
//  GreedyCats
//
//  Created by kevin14 on 15/7/20.
//  Copyright (c) 2015年 kevin14. All rights reserved.
//

import UIKit
import WebKit

class OtherViewController: UIViewController,WKScriptMessageHandler{
    
    private var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initWebView()
    }
    
    func initWebView(){
        var contentController = WKUserContentController()
        contentController.addScriptMessageHandler(self, name: "showMenu")
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.view.frame, configuration: config)
        var url = NSURL(string:"http://localhost:3000/detail.html")
        var req = NSURLRequest(URL:url!)
        webView.loadRequest(req)
        
        self.view.addSubview(webView)
        
    }

    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name{
        case "showMenu":
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

