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
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"]))
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
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

}
