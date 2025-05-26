//
//  Untitled.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

struct Article: Codable {
    let title: String
    let detail: String
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail = "description"
        case date = "pubDate"
    }
}
