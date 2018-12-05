//
//  TopNewsScrollView.swift
//  news
//
//  Created by 王春杉 on 2018/11/12.
//  Copyright © 2018 王春杉. All rights reserved.
//

import UIKit

class TopNewsScrollView: UIView, UIScrollViewDelegate {
    var lastestNew: LastestNews!
    // 要展示的五张图片
    var imageArray = ["","","","","","",""] {
        didSet(new) {
            self.removeFromSuperview()
            timer?.invalidate()
            //timer = nil
            self.addMainView()
        }
    }
    // 每张图的标题
    var contentArray: NSArray? = ["","","","","","",""]
    typealias MyBlock = (_ nums: Int) -> Void
    
    var block1:MyBlock?
    func addButtonBlock(block: @escaping MyBlock) {
        block1 = block
    }
    
    var scrollView: UIScrollView = UIScrollView()
    let pageView = UIPageControl()
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addMainView()
    }
    init(frame: CGRect, lastestNews: LastestNews) {
        super.init(frame: frame)
        self.lastestNew = lastestNews
        self.addMainView()
    }
    
    fileprivate func addMainView() {
        
        self.backgroundColor = UIColor.gray
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        scrollView.contentSize = CGSize(width: CGFloat(imageArray.count)*self.frame.width, height: self.frame.height)
        scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)   // 初始页设为7页中的第二页
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        for index in 0 ..< imageArray.count {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: CGFloat(index)*self.frame.width, y: 64, width:
                scrollView.frame.width, height: scrollView.frame.height)
            // newsImageView.sd_setImage(with: URL(string: lastestNews.stories[index].images![0]))
            imageView.image = UIImage(named: String(describing: imageArray[index]))
            
//            if(index == 0) {
//                print(lastestNew)
//                imageView.sd_setImage(with: URL(string: imageArray[0]))
//            }else if(index == 6) {
//                imageView.sd_setImage(with: URL(string: imageArray[0]))
//            }else {
//                imageView.sd_setImage(with: URL(string: imageArray[0]))
//            }
            // 一个布尔值，它决定了是否用户触发的事件被该视图对象忽略和把该视图对象从事件响应队列中移除。
            imageView.isUserInteractionEnabled = true
            imageView.tag = index+10
            //imageView.contentMode = .scaleToFill
            let tapClick: UITapGestureRecognizer = UITapGestureRecognizer.init(target:
                self, action: #selector(imageClick))
            imageView.addGestureRecognizer(tapClick)
            scrollView.addSubview(imageView)
            // 为头部新闻图片添加标题
            let lable = UILabel()
            lable.frame = CGRect(x: 20, y: self.frame.height-20, width: self.frame.width, height: 80)
            lable.text = (contentArray![index])
            //lable.text = (contentArray![index] as! String)
            imageView.addSubview(lable)
        }
        self.addSubview(scrollView)
        pageView.frame = CGRect(x: 0, y: self.frame.height-20, width: self.frame.width, height: 20)
        pageView.numberOfPages = 5
        self.addSubview(pageView)
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerChange), userInfo: nil, repeats: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.fireDate = NSDate.distantFuture
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timer?.fireDate = NSDate(timeIntervalSinceNow: 3.0) as Date
        let floatX = scrollView.contentOffset.x
        if floatX == self.frame.width*6 {
            scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)
            //imageIndex = 0
            pageView.currentPage = 0
        } else if floatX == 0 {
            scrollView.contentOffset = CGPoint(x: self.frame.width*CGFloat(4), y: 0)
            //imageIndex = 4
            pageView.currentPage = 4
        } else {
            let offset = (scrollView.contentOffset.x + UIScreen.main.bounds.width/2)/UIScreen.main.bounds.width
            pageView.currentPage = Int(offset) - 1
        }
    }
    @objc func imageClick() {
        block1?(pageView.currentPage)
    }
    @objc func timerChange() {
        var currentPage = pageView.currentPage
        if currentPage == 4 {
            currentPage = 0
            UIView.animate(withDuration: 0.0, animations: {
                self.scrollView.contentOffset = CGPoint(x: CGFloat(currentPage+1)*UIScreen.main.bounds.width, y: 0)
            })
        } else {
            currentPage += 1
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollView.contentOffset = CGPoint(x: CGFloat(currentPage+1)*UIScreen.main.bounds.width, y: 0)
            })
        }
        pageView.currentPage = currentPage
    }
    
    override var frame: CGRect {
        didSet(frameNew) {
            let heightNew = frameNew.size.height-frameNew.origin.y
           // let widthNew = heightNew*frameNew.size.width/frameNew.size.height
            let widthNew = frameNew.size.width
            // let image_newX = CGFloat(pageView.currentPage+1)*frameNew.width
            scrollView.frame = CGRect(x: 0, y: frameNew.origin.y, width:frame.width, height: heightNew)
            let imageView0 = scrollView.viewWithTag(10)
            let imageView1 = scrollView.viewWithTag(11)
            let imageView2 = scrollView.viewWithTag(12)
            let imageView3 = scrollView.viewWithTag(13)
            let imageView4 = scrollView.viewWithTag(14)
            let imageView5 = scrollView.viewWithTag(15)
            let imageVIew6 = scrollView.viewWithTag(16)
            //imageView?.frame = CGRect(x: image_newX, y: 0, width: widthNew, height: heightNew)
            imageView0?.frame = CGRect(x: 0, y: 0, width: widthNew, height: heightNew)
            imageView1?.frame = CGRect(x: self.frame.width*1, y: 0, width: widthNew, height: heightNew)
            imageView2?.frame = CGRect(x: self.frame.width*2, y: 0, width: widthNew, height: heightNew)
            imageView3?.frame = CGRect(x: self.frame.width*3, y: 0, width: widthNew, height: heightNew)
            imageView4?.frame = CGRect(x: self.frame.width*4, y: 0, width: widthNew, height: heightNew)
            imageView5?.frame = CGRect(x: self.frame.width*5, y: 0, width: widthNew, height: heightNew)
            imageVIew6?.frame = CGRect(x: self.frame.width*6, y: 0, width: widthNew, height: heightNew)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
