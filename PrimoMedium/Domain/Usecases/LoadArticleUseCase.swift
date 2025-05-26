//
//  LoadArticleUseCase.swift
//  PrimoMedium
//
//  Created by Mew on 24/5/2568 BE.
//
import RxSwift

protocol LoadArticleUseCase {
    func execute() -> Observable<[Article]>
}

final class LoadArticleUseCaseImpl: LoadArticleUseCase {
    private let defaultArticleRepository: DefaultArticleRepository
    
    init(defaultArticleRepository: DefaultArticleRepository) {
        self.defaultArticleRepository = defaultArticleRepository
    }
    
    func execute() -> Observable<[Article]> {
        return defaultArticleRepository.getArticles()
    }
}
