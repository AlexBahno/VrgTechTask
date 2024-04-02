//
//  ArticleTableRowViewCell.swift
//  VrgTechTask
//
//  Created by Alexandr Bahno on 31.03.2024.
//

import UIKit
import SnapKit
import Combine

class ArticleTableRowViewCell: UITableViewCell {
    private var subscriptions = Set<AnyCancellable>()
    
    static let identifier = "ArticleTableRowViewCell"
    
    var viewModel: ArticleTableRowViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 19)
        return label
    }()
    
    private let publishedAndAuthorStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        return stack
    }()
    
    private let publishedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let savedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        imageView.image = UIImage(systemName: "star", withConfiguration: largeConfig)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupStarImage()
        setupTitle()
        setupDescription()
        setupStack()
        setupPublished()
        setupAuthor()
    }
    
    private func setupStarImage() {
        contentView.addSubview(savedImage)
        
        savedImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(35)
        }
    }
    
    private func setupTitle() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(savedImage.snp.leading).inset(-10)
            make.top.equalToSuperview().inset(5)
        }
    }
    
    private func setupDescription() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
    }
    
    private func setupStack() {
        contentView.addSubview(publishedAndAuthorStack)
        
        publishedAndAuthorStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupPublished() {
        publishedAndAuthorStack.addArrangedSubview(publishedLabel)
    }
    
    private func setupAuthor() {
        publishedAndAuthorStack.addArrangedSubview(authorLabel)
    }
    
    func setupCell(with viewModel: ArticleTableRowViewModel) {
        self.viewModel = viewModel
        addTapGesture()
        setupBinding()
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        authorLabel.text = viewModel.author
        publishedLabel.text = viewModel.publisheDate
    }
    
    private func addTapGesture() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        savedImage.addGestureRecognizer(tapGR)
        savedImage.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.saveImageTapped()
        }
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.$isSaved
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSaved in
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
                if isSaved {
                    self?.savedImage.image = UIImage(systemName: "star.fill", withConfiguration: largeConfig)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                } else {
                    self?.savedImage.image = UIImage(systemName: "star", withConfiguration: largeConfig)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                }
            }
            .store(in: &subscriptions)
    }
}
