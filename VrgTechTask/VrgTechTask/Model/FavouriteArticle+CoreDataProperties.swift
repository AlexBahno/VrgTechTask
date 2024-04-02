//
//  FavouriteArticle+CoreDataProperties.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 01.04.2024.
//
//

import Foundation
import CoreData


extension FavouriteArticle {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteArticle> {
        return NSFetchRequest<FavouriteArticle>(entityName: "FavouriteArticle")
    }
    
    @NSManaged public var abstract: String?
    @NSManaged public var author: String?
    @NSManaged public var id: Int64
    @NSManaged public var publishedDate: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
}

extension FavouriteArticle : Identifiable {
    func deleteMovie() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
