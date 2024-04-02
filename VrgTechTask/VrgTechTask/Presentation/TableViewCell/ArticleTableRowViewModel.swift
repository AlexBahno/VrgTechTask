//
//  ArticleTableRowViewModel.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 31.03.2024.
//

import Foundation
import Combine

final class ArticleTableRowViewModel {
    
    var article: Article?
    var id: Int
    var title: String
    var description: String
    var author: String
    var publisheDate: String
    private lazy var manager = CoreDataManager.shared

    @Published private(set) var isSaved: Bool = false
    
    init(with article: Article) {
        self.article = article
        self.id = article.id ?? 0
        self.title = article.title ?? "title"
        self.description = article.abstract ?? "Description"
        self.author = "Written \(article.byline ?? "author")"
        self.publisheDate = "Published: \(article.publishedDate ?? "")"
        isSaved = manager.articles.map({ Int($0.id) }).contains(article.id)
    }
    
    init(with article: FavouriteArticle) {
        self.id = Int(article.id)
        self.title = article.title ?? "title"
        self.description = article.abstract ?? "Description"
        self.author = "Written \(article.author ?? "author")"
        self.publisheDate = "Published: \(article.publishedDate ?? "")"
        isSaved = true
    }
    
    func saveImageTapped() {
        if isSaved {
            deleteArticle()
        } else {
            saveArticle()
        }
        manager.fetchAllArticles()
    }
    
    private func saveArticle() {
        guard let article = article else {
            return
        }
        isSaved = true
        if !manager.articles.map({ Int($0.id) }).contains(article.id) {
            manager.addNew(favourite: article)
        }
    }
    
    private func deleteArticle() {
        isSaved = false
        manager.articles.filter({ $0.id == Int64(id) }).first?.deleteMovie()
    }
}
