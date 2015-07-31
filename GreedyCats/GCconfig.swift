//
//  GCconfig.swift
//  GreedyCats
//
//  Created by kevin14 on 15/7/28.
//  Copyright (c) 2015年 kevin14. All rights reserved.
//

import Foundation
import WebKit

class GCconfig: WKWebViewConfiguration {
    init(context:WKScriptMessageHandler) {
        super.init()
        var contentController = WKUserContentController()
        contentController.addScriptMessageHandler(context, name: "showMenu")
        contentController.addScriptMessageHandler(context, name: "goDetail")
        contentController.addScriptMessageHandler(context, name: "goBack")
        contentController.addScriptMessageHandler(context, name: "goCart")
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
    }
}