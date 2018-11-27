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
        webView = WKWebView(frame: self.view.bounds)
        //var html: String! = "<link rel=\"stylesheet\" href=\"\(detailNews.css[0])\" integrity=\"sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u\" crossorigin=\"anonymous\">" + detailNews.body
        let html: String! = "<head><link rel=\"stylesheet\" href=\"\(detailNews.css[0])\" type=\"text/\" ></head><body>\(detailNews.body)</body>"
        //webView.loadHTMLString(detailNews.body, baseURL: nil)
        webView.loadHTMLString(html, baseURL: nil)
        self.view.addSubview(webView)
        //print(detailNews.body)
//        let url:NSURL = NSURL.init(string: detailNews.css[0])!
//        let request:NSURLRequest = NSURLRequest.init(url: url as URL)
//        webView.load(request as URLRequest)
    }
    // MARK: -初始化头部新闻图片
//    func setHeadImage() {
//        headImage = UIImageView(frame: CGRect(x: 0, y: 44, width: Device.width, height: 250))
//        headImage?.image = UIImage(named: "002.jpg")
//        headImage?.contentMode = .scaleAspectFill
//        view.addSubview(headImage!)
//    }
}
