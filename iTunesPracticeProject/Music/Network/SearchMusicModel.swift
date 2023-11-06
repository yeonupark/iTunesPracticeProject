//
//  Music.swift
//  iTunesPracticeProject
//
//  Created by Yeonu Park on 2023/11/06.
//

import Foundation

struct SearchMusicModel: Codable {
    let resultCount: Int
    let results: [MusicInfo]
}

// MARK: - Result
struct MusicInfo: Codable {
    let wrapperType, artistType, artistName: String?
    let artistLinkURL: String?
    let artistID, amgArtistID: Int?
    let primaryGenreName: String?
    let primaryGenreID: Int?

}
