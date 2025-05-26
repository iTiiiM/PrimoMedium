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
    }

}
