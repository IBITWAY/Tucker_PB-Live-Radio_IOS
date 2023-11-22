//
//  SideMenuViewController.swift
//  OneScreenRadio
//
//  Created by Faraz Rasheed on 17/05/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView1: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var isAbout = false
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        
        if isAbout {
            self.webView1.isHidden = true
            self.textView.isHidden = false
            
            self.textView.text = aboutText
            
        }else {
            self.webView1.isHidden = false
            self.textView.isHidden = true
            
            webView1.navigationDelegate = self
            
            let url = URL(string: urlString)!
            webView1.load(URLRequest(url: url))
            webView1.allowsBackForwardNavigationGestures = true
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        AppDelegate.sharedInstance()?.moveToHomeView()
//        self.navigationController?.popViewController(animated: true)
    }
}
