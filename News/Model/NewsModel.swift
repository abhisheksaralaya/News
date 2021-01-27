//
//  NewsModel.swift
//  News
//
//  Created by Apple on 27/01/21.
//

import Foundation

struct News: Codable {
    var author, created_at, title, url: String?
}

struct NewsHits: Codable {
    var hits: [News]?
    var nbPages: Int?
}

