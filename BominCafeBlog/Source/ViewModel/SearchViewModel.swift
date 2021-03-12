//
//  SearchViewModel.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import Foundation

protocol TableViewReloadDelegate {
	func tableViewReload()
}

class SearchViewModel {
	var delegate: TableViewReloadDelegate!
	var blogList = [Document]()
//	var cafeList = [CafeDocument]()
	
	var listCount: Int = 0
	
	func initialize() {
		self.blogList = []
//		self.cafeList = []
	}
	
//	func allType() {
//		self.listCount = self.blogList.count + self.cafeList.count
//	}
	
	func requestData(_ searchBarText : String, _ type: String) {
		let request = KakaoAPI(type: type, searchBlog: searchBarText, sort: "accuracy")
		request.fetchBlogList {[weak self] result in
			switch result {
				case .failure(let error):
					print("Error : ", error)
				case .success(let blog):
					self?.blogList.append(contentsOf: blog.documents)
					self?.listCount = self?.blogList.count ?? 0
					self?.delegate.tableViewReload()
			}
		}
	}
	
//	func requestCafe(_ searchBarText : String) {
//		let request = KakaoAPI(type: "cafe", searchBlog: searchBarText, sort: "accuracy")
//		request.fetchCafeList {[weak self] result in
//			switch result {
//				case .failure(let error):
//					print("Error : ", error)
//				case .success(let cafe):
//					self?.cafeList.append(contentsOf: cafe.documents)
//					self?.listCount = self?.cafeList.count ?? 0
//					self?.delegate.tableViewReload()
//			}
//		}
//	}
}
