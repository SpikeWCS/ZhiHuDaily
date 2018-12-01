//
//  MainViewController.swift
//  hangge_1028
//
//  Created by hangge on 16/1/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var mainTableView: UITableView?
    var topNewsView: TopNewsScrollView?
    var window: UIWindow?
    var barImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        // 把导航栏设置为透明
        //在ViewDidLoad中设置导航栏需要显示的主题颜色
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 54/255, green: 130/255, blue: 212/255, alpha: 1)
       // self.navigationController?.navigationBar.isTranslucent = false
        //将navigationBar的第一个View,透明度设置成0,这样就可以实现导航栏透明,
        //第一个View指的是导航栏+信息栏的64px的View
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.navigationBar.subviews[0].alpha = 0
        
        
        setTableView()
    }
    var alpha: CGFloat!
    
    // MARK: -初始化TableView
    func setTableView() {
        
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        mainTableView?.separatorStyle = .singleLine
        mainTableView?.backgroundColor = .clear
        mainTableView?.delegate = self
        mainTableView?.dataSource = self
        mainTableView?.tableHeaderView = self.setTopNewsScrollView()
        mainTableView?.isUserInteractionEnabled = true
        self.view.addSubview(mainTableView!)
    }
    // MARK: -初始化头部新闻轮播图
    func setTopNewsScrollView() -> UIView {
        topNewsView = TopNewsScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        topNewsView?.imageArray = ["002.jpg","002.jpg","002.jpg","002.jpg","002.jpg","002.jpg","002.jpg"]
        topNewsView?.addButtonBlock { (nums) in
            print("\(nums)")
        }
        return topNewsView!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.text = "hello"
            cell?.imageView?.image = UIImage(named: "002.jpg")
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            topNewsView?.timer?.fireDate = NSDate.distantFuture
            var rect = mainTableView?.tableHeaderView?.frame
            rect?.origin.y = scrollView.contentOffset.y
            topNewsView?.frame = rect!
        }
        let sectionHeaderHeight: CGFloat = 90
        if(scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }else if(scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
        }
        // MARK: - 导航栏渐变
        //获取ScrollView的偏移量y
        let offsetY = scrollView.contentOffset.y
        //自己设置需要滚动到哪里可以完全显示导航栏
        let scrollValue: CGFloat = 84.0
        //将偏移量除以需要滚动的量,可以得到需要显示的透明度
        var alpha = offsetY / scrollValue
        if alpha >= 1 {
            alpha = 1
        }
        //将透明度赋值给第一个View即可
        self.navigationController?.navigationBar.subviews[0].alpha = alpha
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.navigationController?.pushViewController(NewsDetailController(), animated: true)
    }
    // 自定义section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: 30))
        view.backgroundColor = UIColor(displayP3Red: 60/255, green: 149/255, blue: 222/255, alpha: 1)
        let textLable = UILabel(frame: CGRect(x: 0, y: 0, width: Device.width, height: 29.5))
        textLable.textAlignment = .center
        textLable.textColor = .white
        textLable.text = "2018.11.11"
        textLable.backgroundColor = UIColor(displayP3Red: 60/255, green: 149/255, blue: 222/255, alpha: 1)
        view.addSubview(textLable)
        return view
    }
}
