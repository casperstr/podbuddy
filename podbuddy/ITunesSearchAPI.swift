//
//  ITunesSearchAPI.swift
//  podbuddy
//
//  Created by Casper Strömberg on 2019-10-31.
//  Copyright © 2019 Casper Strömberg. All rights reserved.
//

import Foundation


struct ITunesSearchAPIList : Decodable {
    var results: [ItunesSearchAPIEntry]
}

struct ItunesSearchAPIEntry : Decodable {
    var collectionId: Int
    var artistName: String
    var trackName: String
    var feedUrl: String
    var artworkUrl600: String
}
