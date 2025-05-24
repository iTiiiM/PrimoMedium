//
//  HomeViewModel.swift
//  PrimoMedium
//
//  Created by Mew on 22/5/2568 BE.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    var viewDidLoad: PublishRelay<Void> { get set }
}

protocol HomeViewModelOutput {
    var articles: Driver<[Article]> { get }
}

typealias HomeViewModelIO = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: HomeViewModelIO {

    var viewDidLoad: PublishRelay<Void> = .init()


    private let _articles = BehaviorRelay<[Article]>(value: [])
    
    var articles: Driver<[Article]> {
        _articles.asDriver(onErrorJustReturn: [])
    }
    
    
    private let disposeBag = DisposeBag()
    

    private let loadArticleUseCase: LoadArticleUseCase
    
    init(loadArticleUseCase: LoadArticleUseCase) {
        self.loadArticleUseCase = loadArticleUseCase
        
    }
    
    func bindViewModel() {
        viewDidLoad.withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.loadArticleUseCase.execute()
            }
            .bind(to: _articles)
            .disposed(by: disposeBag)
//
//        articles = viewDidLoad
//            .withUnretained(self)
//            .flatMap {
//                _ in self.loadArticleUseCase.execute()
//            }
//            .asDriver(onErrorJustReturn: [])
//        
//        articles = viewDidLoad
//            .withUnretained(self)
//            .map { owner, _ in
//                print("MEWW VIEWDIDLOAD 2")
//                return owner.blogPosts
//            }
//            .asDriver(onErrorJustReturn: [])
    }
    
    
    
    
    
    
    
    
    let blogPosts = [
        Article(title: "Swift Concurrency", description: "Learn about async/await in Swift.",
                 date: "Jan 5, 2025"),
        Article(title: "UIKit vs SwiftUI", description: "A comparison of two UI frameworks.",
                 date: "Nov 11, 2019"),
        Article(
            title: "Networking in iOS",
            description: "Handling APIs with URLSession.",
            date: "Oct 23, 2022"
        )
    ]
}
