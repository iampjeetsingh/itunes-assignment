//
//  Track.swift
//  iTunes
//
//  Created by Paramjeet on 26/04/23.
//

import Foundation

struct TrackResponse: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let wrapperType: String?
    let trackName: String?
    let artistName: String?
    let description: String?
    let trackPrice: Double?
    let currency: String?
    let artworkUrl100: String?
}
