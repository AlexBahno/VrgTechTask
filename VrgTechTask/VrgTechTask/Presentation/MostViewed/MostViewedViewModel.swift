//
//  MostViewedViewModel.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import Foundation

final class MostViewedViewModel: ViewModelProtocol {
    
    @Published private(set) var articles: [Article] = []
    @Published private(set) var isLoading = false
    
    func fetchArticle() {
        if isLoading {
            return
        }
        isLoading = true
        NetworkManager.shared.getArticles(from: .viewed) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let data):
                if let res = data.results {
                    self?.articles = res
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
