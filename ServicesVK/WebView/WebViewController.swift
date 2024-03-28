//
//  WebViewController.swift
//  ServicesVK
//
//  Created by Ксения Кобак on 28.03.2024.
//

import WebKit


final class WebViewController: UIViewController {

    private let webView = WKWebView()
    
    var link: String
    
    override func loadView() {
        self.view = webView
    }
    
    init(link: String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        webView.allowsLinkPreview = true
    }

    private func setupWebView() {
        guard let url = URL(string: link) else {
            return
        }
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
      
        webView.navigationDelegate = self
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

