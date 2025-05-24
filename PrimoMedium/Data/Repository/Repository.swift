//
//  Repository.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

// Data/Repository/ArticleRepository.swift
protocol ArticleRepository {
    func getArticles() async throws -> [Article]
}

class DefaultArticleRepository: ArticleRepository {
    let localDataSource: LocalArticleDataSource
    let remoteDataSource: RemoteArticleDataSource
    
    init(
        local: LocalArticleDataSource = InMemoryLocalArticleDataSource.init(),
        remote: RemoteArticleDataSource = APIArticleDataSource.init()
    ) {
        self.localDataSource = local
        self.remoteDataSource = remote
    }
    
    func getArticles() async throws -> [Article] {
        let localArticles = localDataSource.fetchArticles()
        if !localArticles.isEmpty {
            return localArticles
        } else {
        
            Task {
                do {
                    let articles = try await remoteDataSource.fetchArticles()
                    return articles
                    print("Fetched \(articles.count) articles")
                } catch {
                    print("Failed to fetch articles: \(error)")
                    return []
                }
            }
            return []
        }
    }
}
