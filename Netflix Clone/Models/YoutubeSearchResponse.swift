//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Caner Çağrı on 20.12.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [Video]
}

struct Video: Codable {
    let id: IdVideo
}

struct IdVideo: Codable {
    let kind: String
    let videoId: String
}
