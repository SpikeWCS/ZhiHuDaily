//
//  CommentsTableViewCell.swift
//  ZhiHuDaily
//
//  Created by 王春杉 on 2018/11/28.
//  Copyright © 2018 王春杉. All rights reserved.
//

import UIKit
class CommentsTableViewCell: UITableViewCell {
    
    let headImage = UIImageView()
    let name = UILabel()
    let mainContent = UILabel()
    let dianZanImage = UIImageView()
    let dianZanNumLable = UILabel()
    let timeField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(comments: Comments, index: Int) {
        self.init(style: .default, reuseIdentifier: "CommentsTableViewCell")
        
        let padding: CGFloat = 15
        print(Device.width)
        // 头像
        // 添加约束后不能使用圆角，需绘制
        headImage.frame = CGRect(x: padding, y: padding, width: Device.width / 10, height: Device.width / 10)
        headImage.sd_setImage(with: URL(string: comments.comments[index].avatar))
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.width / 2
        contentView.addSubview(headImage)

        // 昵称
        name.frame = CGRect(x: padding + headImage.frame.width + padding, y: padding, width: 100, height: 20)
        name.text = comments.comments[index].author
        contentView.addSubview(name)
        //addConstraint(theView: name, width: 100, height: 20, left: padding + headImage.frame.width + padding-5, top: padding-5)
        
        // 点赞
        //dianZanImage.frame = CGRect(x: Device.width-3*padding - 5, y: padding, width: 15, height: 15)
        dianZanImage.image = UIImage(named: "dianzan")
        contentView.addSubview(dianZanImage)
        addConstraint(theView: dianZanImage, width: 15, height: 15, left: Device.width-3*padding - 5, top: padding)
        //dianZanNumLable.frame = CGRect(x: Device.width-2*padding, y: padding, width: 30, height: 15)
        dianZanNumLable.text = "\(comments.comments[index].likes)"
        contentView.addSubview(dianZanNumLable)
        addConstraint(theView: dianZanNumLable, width: 30, height: 15, left:  Device.width-2*padding, top: padding)
        
        // 主内容
        mainContent.frame = CGRect(x: padding + headImage.frame.width + padding - 5, y: padding + name.frame.height + padding - 5, width: Device.width - name.frame.minX - padding, height: 205)
        mainContent.text = "\(comments.comments[index].content)"
        mainContent.numberOfLines = 0
        mainContent.lineBreakMode = .byWordWrapping
        mainContent.adjustsFontSizeToFitWidth = true
        contentView.addSubview(mainContent)
        
//        // 时间
//        timeLable.frame = CGRect(x: padding + headImage.frame.width + padding, y: contentView.frame.height - padding, width: 100, height: 15)
//        timeLable.text = "\(comments.comments[index].time)"
//        timeLable.textColor = .gray
//        print(comments.comments[index].time)
//        contentView.addSubview(timeLable)

    }
    func addConstraint(theView: UIView, width: CGFloat, height: CGFloat, left: CGFloat, top: CGFloat) {
        theView.translatesAutoresizingMaskIntoConstraints = false
        // 添加 width 约束
        let widthConstraint = NSLayoutConstraint(item: theView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: width)
        theView.addConstraint(widthConstraint)
        // 添加 height 约束
        let heightConstraint = NSLayoutConstraint(item: theView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: height)
        theView.addConstraint(heightConstraint)
        // 添加 left 约束
        let leftConstraint = NSLayoutConstraint(item: theView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: left)
        contentView.addConstraint(leftConstraint)
        // 添加 top 约束
        let topConstraint = NSLayoutConstraint(item: theView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: top)
        contentView.addConstraint(topConstraint)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

