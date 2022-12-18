//
//  Movie.swift
//  Netflix Clone
//
//  Created by Caner Çağrı on 18.12.2022.
//

import Foundation

struct TrendingMovies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
