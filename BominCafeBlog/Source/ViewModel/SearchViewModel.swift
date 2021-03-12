//
//  SearchViewModel.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import UIKit

protocol TableViewReloadDelegate {
	func tableViewReload()
}

class SearchViewModel {
	var delegate: TableViewReloadDelegate!
	var blogList = [Document]()
	var cafeList = [Document]()
	var allList = [Document]()
	
	var filterText = "all"
	
	var listCount: Int = 0
	
	func initialize() {
		self.blogList = []
		self.cafeList = []
		self.allList = []
	}
	
	func requestData(_ searchBarText : String, _ type: String) {
		let request = KakaoAPI(type: type, search: searchBarText, sort: "accuracy")
		request.fetchBlogCafeList {[weak self] result in
			switch result {
				case .failure(let error):
					print("Error : ", error)
				case .success(let data):
					if type == "blog" {
						self?.blogList.append(contentsOf: data.documents)
						self?.allList.append(contentsOf: data.documents)
					}
					if type == "cafe" {
						self?.cafeList.append(contentsOf: data.documents)
						self?.allList.append(contentsOf: data.documents)
					}
					self?.sort()
					self?.delegate.tableViewReload()
			}
		}
	}
	
	func sort() {
		let sorted = self.allList.sorted(by: { $0.title < $1.title })
		self.allList = sorted
	}
	
	func clickFilter(text: String) {
		switch text {
			case "Blog":
				self.allList = []
				self.allList = self.blogList
			case "Cafe":
				self.allList = []
				self.allList = self.cafeList
			default:
				break
		}
	}
}
