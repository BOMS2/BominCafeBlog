//
//  FilterView.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

class FilterView: UIView {
	var searchViewModel = SearchViewModel()
	var stackView: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 1
		stackView.alignment = .center
		stackView.backgroundColor = .white
		stackView.layer.borderWidth = 0.5
		stackView.layer.borderColor = UIColor.lightGray.cgColor
		return stackView
	}()
	private let allButton: UIButton = {
		let button = UIButton()
		button.setTitle("All", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private let blogButton: UIButton = {
		let button = UIButton()
		button.setTitle("Blog", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private let cafeButton: UIButton = {
		let button = UIButton()
		button.setTitle("Cafe", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	
	required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setLayout()
		self.allButton.addTarget(self, action:#selector(self.clickButton(_:)), for: .touchUpInside)
		self.blogButton.addTarget(self, action:#selector(self.clickButton(_:)), for: .touchUpInside)
		self.cafeButton.addTarget(self, action:#selector(self.clickButton(_:)), for: .touchUpInside)
	}
	
	func setLayout() {
		self.addSubview(self.stackView)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.allButton)
		self.stackView.addArrangedSubview(self.blogButton)
		self.stackView.addArrangedSubview(self.cafeButton)
	}
	
	@objc func clickButton(_ sender: UIButton) {
		self.searchViewModel.clickFilter(text: sender.currentTitle ?? "all")
	}
}
