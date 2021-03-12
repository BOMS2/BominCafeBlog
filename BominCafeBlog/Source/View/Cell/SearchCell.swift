//
//  SearchCell.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

class SearchCell: UITableViewCell {
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = label.font.withSize(13)
		label.numberOfLines = 0
		return label
	}()
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = label.font.withSize(12)
		label.numberOfLines = 1
		return label
	}()
	private let typeLabel: UILabel = {
		let label = UILabel()
		label.textColor = .red
		label.font = label.font.withSize(12)
		label.numberOfLines = 1
		return label
	}()
	private let dateLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.numberOfLines = 1
		return label
	}()
	public let thumbnailImageView = ThumbnailImageView()
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 3
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
		self.thumbnailImageView.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor).isActive = true
		self.thumbnailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		self.thumbnailImageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.size.width / 3).isActive = true
		self.thumbnailImageView.widthAnchor.constraint(equalTo: self.thumbnailImageView.heightAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.titleLabel)
		self.stackView.addArrangedSubview(self.nameLabel)
		self.stackView.addArrangedSubview(self.dateLabel)
		self.stackView.addArrangedSubview(self.typeLabel)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
	}
	
	public func configure(info : Document) {
		if let cafename = info.cafename {
			self.nameLabel.text = cafename
			self.typeLabel.text = "CAFE"
		} else {
			self.nameLabel.text = info.blogname
			self.typeLabel.text = "BLOG"
		}
		self.titleLabel.text = info.title
		self.dateLabel.text = info.datetime
		self.thumbnailImageView.setImageUrl(info.thumbnail)
	}
}
