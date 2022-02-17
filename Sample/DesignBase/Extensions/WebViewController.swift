//
//  WebViewViewController.swift
//  DesignBase
//
//  Created by Balaji  on 16/02/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mWKWebView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    public var getURl = String()
    public var vcTitle = String()
    
    private var estimatedProgressObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        self.setupEstimatedProgressObserver()
        self.titleLbl.text = vcTitle
        //self.titleLbl.font = .setCustomFont(name: .medium, size: .x16)
        self.titleLbl.textColor = .black
        let request = URLRequest(url: URL(string: getURl)!, cachePolicy: .reloadIgnoringLocalCacheData)
        mWKWebView.navigationDelegate = self
        mWKWebView.load(request)
    }
    
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = mWKWebView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        view.endEditing(true)
        //dismissVC()
    }
}

//MARK:- WKNavigationDelegate Methods
extension WebViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        if progressView.isHidden {
            // Make sure our animation is visible.
            progressView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.33,
                       animations: {
            self.progressView.alpha = 1.0
        })
    }
    
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        UIView.animate(withDuration: 0.33,
                       animations: {
            self.progressView.alpha = 0.0
        },
                       completion: { isFinished in
            // Update `isHidden` flag accordingly:
            //  - set to `true` in case animation was completly finished.
            //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
            self.progressView.isHidden = isFinished
        })
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // if the request is a non-http(s) schema, then have the UIApplication handle
        // opening the request
        if let url = navigationAction.request.url,
           !url.absoluteString.hasPrefix("http://"),
           !url.absoluteString.hasPrefix("https://"),
           UIApplication.shared.canOpenURL(url) {
            // have UIApplication handle the url (sms:, tel:, mailto:, ...)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            // cancel the request (handled by UIApplication)
            decisionHandler(.cancel)
        }
        else {
            // allow the request
            decisionHandler(.allow)
        }
    }
}

