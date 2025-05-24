//
//  RemoteArticleDatasource.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import Foundation

protocol RemoteArticleDataSource {
    func fetchArticles() async throws -> [Article]
}

class APIArticleDataSource: RemoteArticleDataSource {
    
    init() {} 
    func fetchArticles() async throws -> [Article] {
        let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@JasonShen")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode([Article].self, from: data)
        return response
    }
}
