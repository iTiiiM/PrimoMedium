//
//  HomeViewModel.swift
//  PrimoMedium
//
//  Created by Mew on 22/5/2568 BE.
//

struct HomeViewModel {
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
