//
//  SearchCell.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

class SearchCell: UITableViewCell {
	
	private let titleLabel = UILabel()
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = label.font.withSize(12)
		return label
	}()
	private let dateLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor(red: 252/255, green: 60/255, blue: 68/255, alpha: 1)
		return label
	}()
	public let thumbnailImageView = ThumbnailImageView()
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .leading
		return stackView
	}()

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: "SearchCell")
		
		self.setup()
		self.layout()
	}
}

extension SearchCell {
	
	private func setup() {
		self.contentView.backgroundColor = .white
		self.titleLabel.numberOfLines = 0
		self.nameLabel.numberOfLines = 0
	}
	
	private func layout() {
		self.contentView.addSubview(self.thumbnailImageView)
		self.contentView.addSubview(self.stackView)
		self.contentView.addSubview(self.dateLabel)
		self.thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
		self.thumbnailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.thumbnailImageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.size.width / 3).isActive = true
		self.thumbnailImageView.widthAnchor.constraint(equalTo: self.thumbnailImageView.heightAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.titleLabel)
		self.stackView.addArrangedSubview(self.nameLabel)
		self.stackView.addArrangedSubview(self.dateLabel)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: self.thumbnailImageView.trailingAnchor).isActive = true
	}
	
	public func loadBlog(blogInfo : Document) {
		if let cafename = blogInfo.cafename {
			self.nameLabel.text = cafename
		} else {
			self.nameLabel.text = blogInfo.blogname
		}
		self.titleLabel.text = blogInfo.title
		self.dateLabel.text = blogInfo.datetime
		self.thumbnailImageView.setImageUrl(blogInfo.thumbnail)
	}
}
