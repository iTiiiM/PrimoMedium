//
//  Untitled.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

struct Article: Codable {
    let title: String
    let detail: String
    let content: String
    let author: String
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail = "description"
        case content
        case author
        case date = "pubDate"
    }
}

struct ArticleDetail: Codable {
    let title: String
    let author: String
    let content: String
}

