//
//  SearchViewController.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

class SearchViewController: UIViewController {
	
	lazy var searchViewModel = SearchViewModel()

	private var tableView = UITableView()
	private var searchBar = UISearchBar()
	private var searchText = ""
	private let filter: UIButton = {
		let button = UIButton()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.black.cgColor
		button.setTitle("filter", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private let type: UIButton = {
		let button = UIButton()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.black.cgColor
		button.setTitle("type", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private var filterTypeStackView: UIStackView = {
		let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.alignment = .center
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
}

extension SearchViewController {
	private func setup() {
		self.searchViewModel.delegate = self
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
		self.searchBar.delegate = self
		self.searchBar.placeholder = " more than 2 letters"
		
		
	}

	private func setLayout() {
		self.view.backgroundColor = .white
		self.view.addSubview(self.searchBar)
		self.view.addSubview(self.tableView)
		self.searchBar.translatesAutoresizingMaskIntoConstraints = false
		if #available(iOS 11.0, *) {
			self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			self.searchBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
		}
		self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		self.view.addSubview(self.filterTypeStackView)
		self.filterTypeStackView.addArrangedSubview(self.filter)
		self.filterTypeStackView.addArrangedSubview(self.type)
		self.filterTypeStackView.translatesAutoresizingMaskIntoConstraints = false
		self.filterTypeStackView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
		self.filterTypeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.filterTypeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.filterTypeStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.topAnchor.constraint(equalTo: self.filterTypeStackView.bottomAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
	
	func showSearchBarButton(shouldShow: Bool) {
		if shouldShow {
			navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
		} else {
			navigationItem.rightBarButtonItem = nil
		}
	}
	
	func search(shouldShow: Bool) {
		showSearchBarButton(shouldShow: !shouldShow)
		searchBar.showsCancelButton = shouldShow
		navigationItem.titleView = shouldShow ? searchBar : nil
	}
	
	@objc func handleShowSearchBar() {
		search(shouldShow: true)
		searchBar.becomeFirstResponder()
	}
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.searchViewModel.listCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
			return UITableViewCell()
		}
		
		let blog = self.searchViewModel.blogList[indexPath.row]
		cell.loadBlog(blogInfo: blog)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}

extension SearchViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let searchBarText = searchBar.text else { return }
		if searchBarText.count >= 1 {
			self.searchViewModel.initialize()
			self.searchText = searchBarText
			self.searchViewModel.requestData(self.searchText, "blog")
		} else {
			self.searchViewModel.initialize()
			self.searchViewModel.listCount = 0
			tableView.reloadData()
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		search(shouldShow: false)
	}
}

extension SearchViewController: TableViewReloadDelegate {
	func tableViewReload() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
