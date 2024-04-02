//
//  FavouriteArticlesView.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 30.03.2024.
//

import UIKit
import SnapKit
import Combine

class FavouriteArticlesView: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: FavouriteArticlesViewModel
    
    init(viewModel: FavouriteArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ArticleTableRowViewCell.self, forCellReuseIdentifier: ArticleTableRowViewCell.identifier)
        table.backgroundColor = .clear
        return table
    }()
    
    private let noArticleLable: UILabel = {
        let label = UILabel()
        label.text = "There is no Favourites Article"
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        setupTable()
        setupNoArticleLabel()
    }
    
    private func setupTable() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupNoArticleLabel() {
        self.view.addSubview(noArticleLable)
        
        
        noArticleLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.manager.fetchAllArticles()
        self.tableView.reloadData()
        if viewModel.manager.articles.count == 0 {
            noArticleLable.isHidden = false
        } else {
            noArticleLable.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
        
        if viewModel.manager.articles.count == 0 {
            noArticleLable.isHidden = false
        } else {
            noArticleLable.isHidden = true
        }
    }
}
