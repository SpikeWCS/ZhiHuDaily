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
        headImage.frame = CGRect(x: padding, y: padding, width: Device.width / 10, height: Device.width / 10)
        headImage.sd_setImage(with: URL(string: comments.comments[index].avatar))
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.width / 2
        contentView.addSubview(headImage)
        
        // 昵称
        name.frame = CGRect(x: padding + headImage.frame.width + padding, y: padding, width: 100, height: 20)
        name.text = comments.comments[index].author
        contentView.addSubview(name)
        
        // 点赞
        dianZanImage.frame = CGRect(x: Device.width-3*padding - 5, y: padding, width: 15, height: 15)
        dianZanImage.image = UIImage(named: "dianzan")
        contentView.addSubview(dianZanImage)
        
        dianZanNumLable.frame = CGRect(x: Device.width-2*padding, y: padding, width: 30, height: 15)
        dianZanNumLable.text = "\(comments.comments[index].likes)"
        contentView.addSubview(dianZanNumLable)
        
        // 主内容
        mainContent.frame = CGRect(x: padding + headImage.frame.width + padding, y: padding + name.frame.height + padding, width: Device.width - name.frame.minX - padding, height: 205)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

