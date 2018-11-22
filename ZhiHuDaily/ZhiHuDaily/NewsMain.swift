//
//  NewsMain.swift
//  ZhiHuDaily
//
//  Created by 王春杉 on 2018/11/19.
//  Copyright © 2018 王春杉. All rights reserved.
//

import Foundation
import Alamofire

struct NewsHelper {
    static func dataManager(url: String, success: (([String: Any])->())? = nil, failure: ((Error)->())? = nil) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value  {
                    if let dict = data as? [String: Any] {
                        success?(dict)
                    }
                }
            case .failure(let error):
                failure?(error)
                if let data = response.result.value  {
                    if let dict = data as? [String: Any],
                        let errmsg = dict["message"] as? String {
                        print(errmsg)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

struct LastestNewsHelper {
    static func getLastestNews(success: @escaping (LastestNews)->(), failure: @escaping (Error)->()) {
        NewsHelper.dataManager(url: "https://news-at.zhihu.com/api/4/news/latest", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let lastestNews = try? LastestNews(data: data) {
                success(lastestNews)
            }
        }, failure: { _ in
            
        })
    }
}

struct NewsFigure {
    static var id = 0
}

// MARK: - Model
struct LastestNews: Codable {
    let date: String
    let stories, topStories: [Story]
    
    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
}

struct Story: Codable {
    let images: [String]?
    let type, id: Int
    let gaPrefix, title: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case images, type, id
        case gaPrefix = "ga_prefix"
        case title, image
    }
}

// MARK: - Initialization
extension LastestNews {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LastestNews.self, from: data)
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
        date: String? = nil,
        stories: [Story]? = nil,
        topStories: [Story]? = nil
        ) -> LastestNews {
        return LastestNews(
            date: date ?? self.date,
            stories: stories ?? self.stories,
            topStories: topStories ?? self.topStories
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Story {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Story.self, from: data)
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
        images: [String]?? = nil,
        type: Int? = nil,
        id: Int? = nil,
        gaPrefix: String? = nil,
        title: String? = nil,
        image: String?? = nil
        ) -> Story {
        return Story(
            images: images ?? self.images,
            type: type ?? self.type,
            id: id ?? self.id,
            gaPrefix: gaPrefix ?? self.gaPrefix,
            title: title ?? self.title,
            image: image ?? self.image
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
