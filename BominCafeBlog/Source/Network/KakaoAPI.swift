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
	
	init(type: String, search: String, sort: String) {
		let searchString : String = "https://dapi.kakao.com/v2/search/\(type)?query=\(search)&sort=\(sort)&size=25"
		self.sourceURL = convertUrl(searchString)
	}
	
	func fetchBlogCafeList(completion: @escaping(Result<KakaoModel, InfoError>) -> Void) {
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
					let response = try decoder.decode(KakaoModel.self, from: jsonData)
					completion(.success(response))
				} catch {
					completion(.failure(.noData))
				}
			}
			task.resume()
		}
	}
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
