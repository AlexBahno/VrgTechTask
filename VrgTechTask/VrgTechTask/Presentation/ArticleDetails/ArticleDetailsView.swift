//
//  ArticleDetailedView.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 31.03.2024.
//

import UIKit
import SnapKit
import WebKit

class ArticleDetailsView: UIViewController {
    
    var viewModel: ArticleDetailsViewModel
    
    private let webView: WKWebView = {
        let pref = WKPreferences()
        
        let pagePrefs = WKWebpagePreferences()
        pagePrefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.preferences = pref
        config.defaultWebpagePreferences = pagePrefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configView()
    }
    
    private func configView() {
        guard let url = URL(string: viewModel.url) else { return }
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
        
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ArticleDetailsView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard let _ = result as? String, error == nil else {
                print("Failed to get html")
                return
            }
        }
    }
}
