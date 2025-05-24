//
//  Repository.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import RxSwift

// Data/Repository/ArticleRepository.swift
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
//        return localDataSource.fetchArticles()
//            .flatMap { local in
//                if !local.isEmpty {
//                    return Observable.just(local)
//                } else {
//                    return Observable.create { observer in
//                        Task {
//                            do {
//                                let remote = try await self.remoteDataSource.fetchArticles()
//                                
//                                observer.onCompleted()
//                            } catch {
//                                print("Failed to fetch remote articles: \(error)")
//                                observer.onNext([]) // fallback value
//                                observer.onCompleted()
//                            }
//                        }
//                        return Disposables.create()
//                    }
//                }
//            }
        let localArticles = localDataSource.fetchArticles()
        return localArticles.flatMapLatest {
            if !$0.isEmpty {
                return localArticles
            } else {
                return self.remoteDataSource.fetchArticles()
            }
//                return Observable.create { observer in
//                    Task {
//                        do {
//                            let remote = try await self.remoteDataSource.fetchArticles()
//                            observer.onNext(remote)
//                            observer.onCompleted()
//                        } catch {
//                            print("Failed to fetch remote articles: \(error)")
//                            observer.onNext([])
//                            observer.onCompleted()
//                        }
//                    }
//                    return Disposables.create()
//            }
        }
}
}
