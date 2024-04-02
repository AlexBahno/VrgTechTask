//
//  MostEmailedView.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 29.03.2024.
//

import UIKit
import SnapKit
import Combine

class MostEmailedView: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: MostEmailedViewModel
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ArticleTableRowViewCell.self, forCellReuseIdentifier: ArticleTableRowViewCell.identifier)
        table.backgroundColor = .clear
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    init(viewModel: MostEmailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBinding()
        viewModel.fetchArticle()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        if !NetworkMonitor.shared.isConnected {
            let alertController = UIAlertController(title: "Internet connection failed", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    
    private func setupBinding() {
        viewModel.$articles
            .receive(on: DispatchQueue.global())
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }

    private func setupUI() {
        setupTable()
        setupActivityIndicator()
    }
    
    private func setupTable() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

