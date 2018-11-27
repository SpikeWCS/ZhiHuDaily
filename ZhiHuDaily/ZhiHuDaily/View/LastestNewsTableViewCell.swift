//
//  LastestNewsTableViewCell.swift
//  ZhiHuDaily
//
//  Created by 王春杉 on 2018/11/20.
//  Copyright © 2018 王春杉. All rights reserved.
//

import UIKit

class LastestNewsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(lastestNews: LastestNews, index: Int) {
        self.init(style: .default, reuseIdentifier: "LastestNewsTableViewCell")
        
        let padding: CGFloat = 15
        let border: CGFloat = 65
        
        titleLabel.frame = CGRect(x: padding, y: padding, width: Device.width - 3 * padding - border, height: border)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = lastestNews.stories[index].title
        contentView.addSubview(titleLabel)
        
        newsImageView.frame = CGRect(x: titleLabel.frame.maxX + padding, y: titleLabel.frame.minX, width: border, height: border-15)
        newsImageView.sd_setImage(with: URL(string: lastestNews.stories[index].images![0]))
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
