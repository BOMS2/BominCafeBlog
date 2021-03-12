//
//  KakaoModel.swift
//  BominCafeBlog
//
//  Created by 김보민 on 2021/03/12.
//

import Foundation

struct KakaoModel: Codable {
	let meta: Meta
	let documents: [Document]
	
	enum CodingKeys: String, CodingKey {
		case documents
		case meta
	}
}

struct Meta: Codable {
	let total_count: Int
	let is_end: Bool
	let pageable_count: Int
	
	enum CodingKeys: String, CodingKey {
		case total_count
		case is_end
		case pageable_count
	}
}

struct Document: Codable {
	var blogname: String?
	var cafename: String?
	var contents: String
	var datetime: String
	var thumbnail: String
	var title: String
	var url: String
	
	enum CodingKeys: String, CodingKey {
		case blogname
		case cafename
		case contents
		case datetime
		case thumbnail
		case title
		case url
	}
}
