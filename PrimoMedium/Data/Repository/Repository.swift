//
//  Repository.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

// Data/Repository/ArticleRepository.swift
protocol ArticleRepository {
    func getArticles(completion: @escaping ([Article]) -> Void)
}

class DefaultArticleRepository: ArticleRepository {
    let localDataSource: LocalArticleDataSource
    let remoteDataSource: RemoteArticleDataSource
    
    init(local: LocalArticleDataSource, remote: RemoteArticleDataSource) {
        self.localDataSource = local
        self.remoteDataSource = remote
    }
    
    func getArticles(completion: @escaping ([Article]) -> Void) {
        let localArticles = localDataSource.fetchArticles()
        if !localArticles.isEmpty {
            completion(localArticles)
        } else {
            remoteDataSource.fetchArticles { remoteArticles in
                self.localDataSource.saveArticles(remoteArticles)
                completion(remoteArticles)
            }
        }
    }
}
