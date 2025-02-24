//
//  MovieDTO.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }

    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Constants.imageBaseURL)\(posterPath)")
    }

}
