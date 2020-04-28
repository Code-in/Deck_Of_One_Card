//
//  File.swift
//  DeckOfOneCard
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let image: URL
    let code: String
    let value: String
    let suit: String
}
