//
//  Constant.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import Foundation

struct Constants {
    
    static let base_url = "https://api.nytimes.com/svc/mostpopular/v2"
    
    static let api_key = "u6yISocNIB2XYFL8NTWJ4G38V1siVS7v"
}

enum TypeOfArticles: String {
    case emailed = "/emailed/30.json?"
    case shared = "/shared/30.json?"
    case viewed = "/viewed/30.json?"
}
