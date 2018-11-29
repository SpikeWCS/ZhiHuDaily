//
//  CommentsController.swift
//  ZhiHuDaily
//
//  Created by 王春杉 on 2018/11/28.
//  Copyright © 2018 王春杉. All rights reserved.
//

import UIKit
import SDWebImage

class CommentsController: UIViewController {
    var comments: Comments!
    var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        CommentsHelper.getComments(success: { comments in
            self.comments = comments
            self.commentsLoad()
        }) { _ in
            
        }
        
    }
    
    func commentsLoad() {
        commentsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        commentsTableView.separatorStyle = .singleLine
        commentsTableView.backgroundColor = .clear
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.isUserInteractionEnabled = true
        self.view.addSubview(commentsTableView)
    }
}

extension CommentsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("commentsNum: \(comments.comments.count)")
        return comments.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if comments == nil { return UITableViewCell() }
        return CommentsTableViewCell(comments: comments, index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(commentsTableView.contentOffset.y <= 120) {
            commentsTableView.bounces = false
        }else {
            commentsTableView.bounces = true
        }
    }
}
