//
//  HomeViewModel.swift
//  PrimoMedium
//
//  Created by Mew on 22/5/2568 BE.
//

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
    var articles: [Article] { get }
}

typealias HomeViewModelIO = HomeViewModelInput & HomeViewModelOutput

struct HomeViewModel: HomeViewModelIO {


    var articles: [Article]

    private let loadArticleUseCase: LoadArticleUseCase
    
    init(loadArticleUseCase: LoadArticleUseCase) {
        self.loadArticleUseCase = loadArticleUseCase
    }
    
    func viewDidLoad() async {
        articles = try await loadArticleUseCase.execute()
    }
    
    
    
    
    let blogPosts = [
        BlogPost(title: "Swift Concurrency", description: "Learn about async/await in Swift.",
                 date: "Jan 5, 2025"),
        BlogPost(title: "UIKit vs SwiftUI", description: "A comparison of two UI frameworks.",
                 date: "Nov 11, 2019"),
        BlogPost(
            title: "Networking in iOS",
            description: "Handling APIs with URLSession.",
            date: "Oct 23, 2022"
        )
    ]
}
