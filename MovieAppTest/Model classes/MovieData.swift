//
//  RootModel.swift
//  MovieAppTest
//
//  Created by REVE Systems on 22/11/23.
//

import Foundation

struct MovieData: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
