//
//  LoadArticleUseCase.swift
//  PrimoMedium
//
//  Created by Mew on 24/5/2568 BE.
//

protocol LoadArticleUseCase {
    func execute() async throws -> [Article]
}

final class LoadArticleUseCaseImpl: LoadArticleUseCase {
    private let defaultArticleRepository: DefaultArticleRepository
    
    init(defaultArticleRepository: DefaultArticleRepository) {
        self.defaultArticleRepository = defaultArticleRepository
    }
    
    func execute() async throws -> [Article] {
        let articles = try await defaultArticleRepository.getArticles()
        return articles
    }
}
