//
//  Comments.swift
//  ZhiHuDaily
//
//  Created by 王春杉 on 2018/11/28.
//  Copyright © 2018 王春杉. All rights reserved.
//

import Foundation
import Alamofire


struct CommentsHelper {
    static func getComments(success: @escaping (Comments)->(), failure: @escaping (Error)->()) {
        NewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/story/\(NewsFigure.id)/long-comments", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let comments = try? Comments(data: data) {
                success(comments)
            }
        }, failure: { _ in
            
        })
    }
}

struct Comments: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let author, content: String
    let avatar: String
    let time, id, likes: Int
    let replyTo: ReplyTo?
    
    enum CodingKeys: String, CodingKey {
        case author, content, avatar, time, id, likes
        case replyTo = "reply_to"
    }
}

struct ReplyTo: Codable {
    let content: String
    let status, id: Int
    let author: String
}

// MARK: Convenience initializers and mutators

extension Comments {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comments.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        comments: [Comment]? = nil
        ) -> Comments {
        return Comments(
            comments: comments ?? self.comments
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Comment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comment.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        author: String? = nil,
        content: String? = nil,
        avatar: String? = nil,
        time: Int? = nil,
        id: Int? = nil,
        likes: Int? = nil,
        replyTo: ReplyTo?? = nil
        ) -> Comment {
        return Comment(
            author: author ?? self.author,
            content: content ?? self.content,
            avatar: avatar ?? self.avatar,
            time: time ?? self.time,
            id: id ?? self.id,
            likes: likes ?? self.likes,
            replyTo: replyTo ?? self.replyTo
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ReplyTo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReplyTo.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        content: String? = nil,
        status: Int? = nil,
        id: Int? = nil,
        author: String? = nil
        ) -> ReplyTo {
        return ReplyTo(
            content: content ?? self.content,
            status: status ?? self.status,
            id: id ?? self.id,
            author: author ?? self.author
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
