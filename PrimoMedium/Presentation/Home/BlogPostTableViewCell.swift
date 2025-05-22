//
//  BlogPostTableViewCell.swift
//  PrimoMedium
//
//  Created by Mew on 22/5/2568 BE.
//
import UIKit

struct BlogPost {
    let title: String
    let description: String
    let date: String
}

class BlogPostCell: UITableViewCell {
    // MARK: - UI Elements
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func configure(with post: BlogPost) {
        titleLabel.text = post.title
        descriptionLabel.text = post.description
        dateLabel.text = post.date
    }
    
    private func setupViews() {
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                
                
                dateLabel.topAnchor
                    .constraint(
                        equalTo: descriptionLabel.bottomAnchor,
                        constant: 12
                    ),
                dateLabel.leadingAnchor
                    .constraint(equalTo: descriptionLabel.leadingAnchor),
                dateLabel.trailingAnchor
                    .constraint(equalTo: descriptionLabel.trailingAnchor),
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ]
        )
    }
    
    
}
