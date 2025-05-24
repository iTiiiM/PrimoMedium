//
//  LocalArticleDatarouce.swift
//  PrimoMedium
//
//  Created by Mew on 23/5/2568 BE.
//

import CoreData

protocol LocalArticleDataSource {
    func fetchArticles() -> [Article]
    func saveArticles(_ articles: [Article])
}

// Example CoreData or in-memory storage
class InMemoryLocalArticleDataSource: LocalArticleDataSource {
    private let context: NSManagedObjectContext
    
    init(
        context: NSManagedObjectContext = CoreDataStack.shared.context
    ) {
        self.context = context
    }
    
    func fetchArticles() -> [Article] {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            return entities
                .map {
                    Article(
                        title: $0.title ?? "",
                        author: $0.author ?? "",
                        content: $0.content ?? ""
                    )
                }
        } catch {
            print("Failed to fetch articles: \(error)")
            return []
        }
    }
    
    func saveArticles(_ articles: [Article]) {
        for article in articles {
            let entity = ArticleEntity(context: context)
            entity.title = article.title
            entity.author = article.author
            entity.content = article.content
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save articles: \(error)")
        }
    }
}


class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PrimoMedium") // Replace with your model name
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
