//
//  FavouriteArticles+TableView.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 01.04.2024.
//

import UIKit

extension FavouriteArticlesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.manager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableRowViewCell.identifier, for: indexPath)
                as? ArticleTableRowViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: ArticleTableRowViewModel(with: viewModel.manager.articles[indexPath.row]), isShowStarImage: false)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = ArticleDetailsViewModel(url: viewModel.manager.articles[indexPath.row].url ?? "")
        navigationController?.pushViewController(ArticleDetailsView(viewModel: vm), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.viewModel.manager.articles[indexPath.row].deleteMovie()
            self.viewModel.manager.fetchAllArticles()
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}
