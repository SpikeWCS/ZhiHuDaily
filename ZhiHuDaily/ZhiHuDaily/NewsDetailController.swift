//
//  NewsDetailController.swift
//  news
//
//  Created by 王春杉 on 2018/11/14.
//  Copyright © 2018 王春杉. All rights reserved.
//

import UIKit
import WebKit
class NewsDetailController: UIViewController {
    var headImage: UIImageView?
    var scrollView: UIScrollView?
    var detailNews: DetailNews!
    var webView: WKWebView!
    var rightBarBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        DetailNewsHelper.getDetailNews(success: { detailNews in
            self.detailNews = detailNews
            print(detailNews.id)
            self.detailNewLoad()
        }) { _ in
            
        }
        
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: Device.width, height: 400))
//        setHeadImage()
    }
    
    func detailNewLoad() {
        // 加载h主内容
        webView = WKWebView(frame: self.view.bounds)
        var html = "<head>"
        for css in detailNews.css {
            html += "<link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\"/>"
        }
        html += "</head>" + detailNews.body
        for js in detailNews.js {
            html += "<script src=\"\(js)\"></script>"
        }
        webView.loadHTMLString(html, baseURL: nil)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(webView)
        
        setRightBarBtn()
    }
    // MARK: - 初始化头部新闻图片
//    func setHeadImage() {
//        headImage = UIImageView(frame: CGRect(x: 0, y: 44, width: Device.width, height: 250))
//        headImage?.image = UIImage(named: "002.jpg")
//        headImage?.contentMode = .scaleAspectFill
//        view.addSubview(headImage!)
//    }
    
    // MARK: - 设置右导航栏
    func setRightBarBtn() {
        rightBarBtn = UIBarButtonItem(title: "评论", style: .plain, target: self, action: #selector(clickRightBarBtn))
        rightBarBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func clickRightBarBtn() {
        self.navigationController?.pushViewController(CommentsController(), animated: true)
    }
}

extension NewsDetailController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '200%'", completionHandler: nil)
        
    }
}
