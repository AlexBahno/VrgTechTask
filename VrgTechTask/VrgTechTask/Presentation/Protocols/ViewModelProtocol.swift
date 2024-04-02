//
//  ViewModelInterface.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    func fetchArticle()
}
