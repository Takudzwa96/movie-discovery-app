//
//  PopularDTO.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

struct PopularResponse: Decodable {
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
