//
//  NetworkManager.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case cannnotParseData
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getArticles(from type: TypeOfArticles,
                     completion: @escaping (Result<ArticleResponse, Error>) -> Void
    ) {
        let url = Constants.base_url + type.rawValue + "api-key=" + Constants.api_key
        print(url)
        
        AF.request(url)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                let results = try? decoder.decode(ArticleResponse.self, from: data)
                guard let results = results else {
                    completion(.failure(NetworkError.cannnotParseData))
                    return
                }
                completion(.success(results))
            }
    }
}
