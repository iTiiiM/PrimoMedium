//
//  ReaderWebViewController.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import UIKit
import WebKit

class ReaderWebViewController: UIViewController {
    
    var webView: WKWebView!
    
    // Your article data
    var articleTitle: String = ""
    var articleAuthor: String = ""
    var articleContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadReaderContent()
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }
    
    private func loadReaderContent() {
        // Sanitize or encode content if needed
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 20px; line-height: 1.6; background-color: #f9f9f9; color: #333; }
                h1 { font-size: 28px; margin-bottom: 10px; }
                .author { font-size: 16px; color: #666; margin-bottom: 20px; }
                img { max-width: 100%; height: auto; border-radius: 8px; }
                pre { background-color: #eee; padding: 10px; border-radius: 6px; overflow-x: auto; }
                code { font-family: Menlo, monospace; font-size: 14px; }
            </style>
        </head>
        <body>
            <h1>\(articleTitle)</h1>
            <div class="author">by \(articleAuthor)</div>
            \(articleContent)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
