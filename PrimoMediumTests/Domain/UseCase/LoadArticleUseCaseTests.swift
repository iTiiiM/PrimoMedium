//
//  LoadArticleUseCase.swift
//  PrimoMedium
//
//  Created by Mew on 27/5/2568 BE.
//
import Testing
import XCTest
import RxSwift

@testable import PrimoMedium

struct LoadArticleUseCaseTests {
    func test_viewDidLoad_loadsArticles() {
        // Given
        let mockUseCase = MockLoadArticleUseCase()
        mockUseCase.articlesToReturn = [
            Article(title: "Test", detail: "detail", content: "", author: "", date: "")
        ]
        
        let viewModel = HomeViewModel(loadArticleUseCase: mockUseCase)
        
        var output: [[Article]] = []
        let disposeBag = DisposeBag()
        
        viewModel.articles
            .drive(onNext: { output.append($0) })
            .disposed(by: disposeBag)
        
        // When
        viewModel.viewDidLoad.accept(())
        
        // Then
        XCTAssertEqual(output.count, 1)
        XCTAssertEqual(output[0].first?.title, "Test")
    }
    
    func test_formatDate() {
        let input = "2025-05-14 15:58:14"
        let result = input.formatHTMLToString()
        XCTAssertEqual(result.string, "14 May 2025")
    }
    
    func test_repository_fallsBackToRemote_whenLocalIsEmpty() {
        let local = MockLocalDataSource()
        local.result = [] // Empty
        
        let remote = MockRemoteDataSource()
        remote.result = [Article(title: "From Remote", detail: "", content: "", author: "", date: "")]
        
        let repo = DefaultArticleRepository(local: local, remote: remote)
        
        var output: [Article] = []
        _ = repo.getArticles()
            .subscribe(onNext: { output = $0 })
        
        XCTAssertEqual(output.first?.title, "From Remote")
    }
}


class MockLoadArticleUseCase: LoadArticleUseCase {
    var articlesToReturn: [Article] = []
    
    func execute() -> Observable<[Article]> {
        return Observable.just(articlesToReturn)
    }
}


class MockLocalDataSource: LocalArticleDataSource {
    func saveArticles(_ articles: [PrimoMedium.Article]) {
        return
    }
    
    var result: [Article] = []
    func fetchArticles() -> Observable<[Article]> {
        return Observable.just(result)
    }
}

class MockRemoteDataSource: RemoteArticleDataSource {
    var result: [Article] = []
    func fetchArticles() -> Observable<[Article]> {
        return Observable.just(result)
    }
}



