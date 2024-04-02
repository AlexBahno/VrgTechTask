//
//  CoreDateManager.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 01.04.2024.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    var articles = [FavouriteArticle]()
    
    private init() {
        fetchAllArticles()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouriteArticle")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllArticles() {
        let req = FavouriteArticle.fetchRequest()
        if let articles = try? persistentContainer.viewContext.fetch(req) {
            self.articles = articles
        }
    }
    
    func addNew(favourite article: Article) {
        let savedArticle = FavouriteArticle(context: persistentContainer.viewContext)
        savedArticle.id = Int64(article.id ?? 0)
        savedArticle.title = article.title ?? "title"
        savedArticle.abstract = article.abstract ?? "Description"
        savedArticle.url = article.url ?? ""
        savedArticle.publishedDate = article.publishedDate ?? "Date"
        savedArticle.author = article.byline ?? "Author"
        saveContext()
        fetchAllArticles()
    }
}
