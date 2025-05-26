//
//  Response.swift
//  PrimoMedium
//
//  Created by Mew on 24/5/2568 BE.
//

import Foundation

public class Response<T: Codable>: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case feed
        case items
    }
    
    public let status: String
    public var feed: Feed
    var items: [T]?

    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: CodingKeys.status)
        feed = try container.decode(Feed.self, forKey: CodingKeys.feed)
        items = try container
            .decodeIfPresent([T].self, forKey: CodingKeys.items)

    }
}

public class Feed: Codable {
    var title: String
}
