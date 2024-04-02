//
//  MostViewedView+TabelView.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import UIKit

extension MostViewedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableRowViewCell.identifier, for: indexPath)
                as? ArticleTableRowViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: ArticleTableRowViewModel(with: viewModel.articles[indexPath.row]), isShowStarImage: true)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = ArticleDetailsViewModel(url: viewModel.articles[indexPath.row].url ?? "")
        navigationController?.pushViewController(ArticleDetailsView(viewModel: vm), animated: true)
    }
}
