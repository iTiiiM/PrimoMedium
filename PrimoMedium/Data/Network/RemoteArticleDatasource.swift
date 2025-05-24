//
//  RemoteArticleDatasource.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import Foundation
protocol RemoteArticleDataSource {
    func fetchArticles(completion: @escaping ([Article]) -> Void)
}

class APIArticleDataSource: RemoteArticleDataSource {
    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        // Fake example, replace with real network call
        let urlRequest = URLRequest(
            url: URL(
                string: "https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@JasonShen"
            )!
        )
        URLSession.shared.data(with: urlRequest) { data, response, error in
            guard let data = data as? [Article] else { return completion([])}
            completion(data)
        }

    }
}

