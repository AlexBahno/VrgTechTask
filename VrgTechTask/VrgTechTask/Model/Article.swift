//
//  Article.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import Foundation

struct ArticleResponse: Codable {
    let results: [Article]?
}



struct Article: Identifiable, Codable {
    let url: String?
    let id: Int?
    let source: String?
    let publishedDate, updated, section: String?
    let nytdsection, adxKeywords: String?
    let byline: String?
    let title, abstract: String?
    let media: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case url, id
        case source
        case publishedDate = "published_date"
        case updated, section, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, title, abstract
        case media
    }
}

struct Media: Codable {
    let type: String?
    let mediaMetadata: [MediaMetadatum]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String?
    let format: String?
    let height, width: Int?
}
