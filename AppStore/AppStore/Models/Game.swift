//
//  Game.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 7.03.2022.
//

import Foundation

struct listOfGames: Decodable {
    let next: String
    let results: [Game]
}
struct Game: Decodable {
    let id: Int
    let name: String
    let background_image: String
    let rating: Double
    let released: String
}
struct GameDetail: Decodable {
    let id: Int
    let name: String
    let background_image: String
    let metacritic: Int
    let description_raw: String
    let released: String
    let rating: Double
}
