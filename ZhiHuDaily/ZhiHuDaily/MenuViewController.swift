//
//  MenuViewController.swift
//  hangge_1028
//
//  Created by hangge on 16/1/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var headImage: UIImageView?
    var nameLable: UILabel?
    var shouCangBtn: UIButton?
    var xiaoXiBtn: UIButton?
    var sheZhiBtn: UIButton?
    var shouYeBtn: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 36/255, green: 41/255, blue: 47/255, alpha: 1)
        
        // 头像
        headImage = UIImageView()
        headImage?.image = UIImage(named: "002.jpg")
        headImage?.frame = CGRect(x: 20, y: 44, width: 50, height: 50)
        headImage?.layer.cornerRadius = 25
        headImage?.layer.masksToBounds = true
        self.view.addSubview(headImage!)
        
        // 昵称
        nameLable = UILabel()
        nameLable?.frame = CGRect(x: 100, y: 44, width: Device.width/2-100, height: 50)
        nameLable?.text = "默然恨"
        nameLable?.textColor = .white
        nameLable?.textAlignment = NSTextAlignment.left
        self.view.addSubview(nameLable!)
        
        setShouCangBtn()
        setXiaoXiBtn()
        setSheZhiBtn()
        setShouYeBtn()
    }
    
    // MARK: -初始化收藏按钮
    func setShouCangBtn() {
        shouCangBtn = UIButton()
        shouCangBtn?.setBackgroundImage(UIImage(named: "shoucang"), for: .normal)
        shouCangBtn?.frame = CGRect(x: 17, y: 114, width: 30, height: 30)
        self.view.addSubview(shouCangBtn!)
        
        let shoucangLable = UILabel()
        shoucangLable.frame = CGRect(x: 15, y: 149, width:40, height: 20)
        shoucangLable.text = "收藏"
        shoucangLable.textColor = .white
        self.view.addSubview(shoucangLable)
    }
    
    // MARK: -初始化消息按钮
    func setXiaoXiBtn() {
        xiaoXiBtn = UIButton()
        xiaoXiBtn?.setBackgroundImage(UIImage(named: "xiaoxi"), for: .normal)
        xiaoXiBtn?.frame = CGRect(x: 92, y: 110, width: 30, height: 30)
        self.view.addSubview(xiaoXiBtn!)
        
        let xiaoxiLable = UILabel()
        xiaoxiLable.frame = CGRect(x: 90, y: 149, width:40, height: 20)
        xiaoxiLable.text = "消息"
        xiaoxiLable.textColor = .white
        self.view.addSubview(xiaoxiLable)
    }
    
    // MARK: -初始化设置按钮
    func setSheZhiBtn() {
        sheZhiBtn = UIButton()
        sheZhiBtn?.setBackgroundImage(UIImage(named: "shezhi"), for: .normal)
        sheZhiBtn?.frame = CGRect(x: 165, y: 110, width: 30, height: 30)
        self.view.addSubview(sheZhiBtn!)
        
        let shezhiLable = UILabel()
        shezhiLable.frame = CGRect(x: 163, y: 149, width:40, height: 20)
        shezhiLable.text = "消息"
        shezhiLable.textColor = .white
        self.view.addSubview(shezhiLable)
    }
    
    // MARK: -初始化首页按钮
    func setShouYeBtn() {
        shouYeBtn = UIButton()
        shouYeBtn?.frame = CGRect(x: 20, y: 200, width: 30, height: 30)
        shouYeBtn?.setBackgroundImage(UIImage(named: "yemian"), for: .normal)
        self.view.addSubview(shouYeBtn!)
        
        let shouyeLable = UILabel()
        shouyeLable.frame = CGRect(x: 65, y: 200, width: 150, height: 30)
        shouyeLable.text = "首页"
        shouyeLable.textColor = .white
        self.view.addSubview(shouyeLable)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

