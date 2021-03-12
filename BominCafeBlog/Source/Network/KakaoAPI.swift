//
//  KakaoAPI.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import Foundation
import UIKit

enum InfoError:Error {
	case noRequest
	case noData
}

struct KakaoAPI {
	var sourceURL : URL? = nil
	
	init(type: String, searchBlog: String, sort: String) {
		let searchString : String = "https://dapi.kakao.com/v2/search/\(type)?query=\(searchBlog)&sort=\(sort)&size=25"
		self.sourceURL = convertUrl(searchString)
	}
	
	func fetchBlogList(completion: @escaping(Result<Blog, InfoError>) -> Void) {
		if let url = self.sourceURL {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			request.addValue("KakaoAK 99862f133c1f3ef0615ee34404a97508", forHTTPHeaderField: "Authorization")
			
			let task = URLSession.shared.dataTask(with: request) { data, _, _ in
				guard let jsonData = data else {
					completion(.failure(.noRequest))
					return
				}
				do {
					let decoder = JSONDecoder()
					let blogResponse = try decoder.decode(Blog.self, from: jsonData)
					completion(.success(blogResponse))
				} catch {
					completion(.failure(.noData))
				}
			}
			task.resume()
		}
	}
	
//	func fetchCafeList(completion: @escaping(Result<Cafe, InfoError>) -> Void) {
//		if let url = self.sourceURL {
//			var request = URLRequest(url: url)
//			request.httpMethod = "GET"
//			request.addValue("KakaoAK 99862f133c1f3ef0615ee34404a97508", forHTTPHeaderField: "Authorization")
//			
//			let task = URLSession.shared.dataTask(with: request) { data, _, _ in
//				guard let jsonData = data else {
//					completion(.failure(.noRequest))
//					return
//				}
//				do {
//					let decoder = JSONDecoder()
//					let cafeResponse = try decoder.decode(Cafe.self, from: jsonData)
//					completion(.success(cafeResponse))
//				} catch {
//					completion(.failure(.noData))
//				}
//			}
//			task.resume()
//		}
//	}
}

extension KakaoAPI {
	func convertUrl(_ sourceString : String) -> URL {
		guard let stringurlfixed = sourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let sourceURL = URL(string: stringurlfixed)
		else {
			print(sourceString)
			fatalError()
		}
		return sourceURL
	}
}
