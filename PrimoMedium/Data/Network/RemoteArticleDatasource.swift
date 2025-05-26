//
//  RemoteArticleDatasource.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//
import RxSwift
import Foundation

protocol RemoteArticleDataSource {
    func fetchArticles() -> Observable<[Article]>
}

class APIArticleDataSource: RemoteArticleDataSource {
    
    init() {} 
    func fetchArticles() -> Observable<[Article]> {
        return Observable.create { observer in
            let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@JasonShen")!
            
            let task = URLSession.shared.dataTask(with: url) {
 data,
 response,
 error in
                if let error = error {
                    observer.onNext([])
                    
                    return
                }
                
                guard let data = data else {
                    observer.onNext([])

                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(
                        Response<Article>.self,
                        from: data
                    )
                    observer.onNext(decoded.items ?? [])
                    observer.onCompleted()
                } catch {
                    observer.onNext([])
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

}
