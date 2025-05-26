//
//  Repository.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import RxSwift

protocol ArticleRepository {
    func getArticles() -> Observable<[Article]>
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
    
    func getArticles() -> Observable<[Article]> {
        let localArticles = localDataSource.fetchArticles()
        return localArticles.flatMapLatest {
            if !$0.isEmpty {
                return localArticles
            } else {
                return self.remoteDataSource.fetchArticles()
            }
        }
}
}
