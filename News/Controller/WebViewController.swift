//
//  WebViewController.swift
//  News
//
//  Created by Apple on 27/01/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let preferences = WKPreferences()
        
        let webConfiguration = WKWebViewConfiguration()
        
        webConfiguration.preferences = preferences
        webConfiguration.allowsInlineMediaPlayback = true
        
        var webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        self.webView?.contentMode = UIView.ContentMode.scaleAspectFit
//        self.webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.frame = self.view.frame
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        webView.load(urlRequest)
    }
    

}
