//
//  GameManager.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 11.03.2022.
//

import Foundation


enum GameManager {
    enum Section: String, CaseIterable {
        case Highlights = "Highlights"
    }
    
    static var gamesHighlights = [
        Section.Highlights: [
            VideoGames(nameTitle: "rdr2", headImage: #imageLiteral(resourceName: "rdr2"), gameThumbnail: #imageLiteral(resourceName: "rdr2"), gameDescription: "Red Dead Redemption 2"),
            VideoGames(nameTitle: "godofwar", headImage: #imageLiteral(resourceName: "godofwar"), gameThumbnail: #imageLiteral(resourceName: "godofwar"), gameDescription: "God of War"),
            VideoGames(nameTitle: "mafia", headImage: #imageLiteral(resourceName: "mafia"), gameThumbnail: #imageLiteral(resourceName: "mafia"), gameDescription: "Mafia"),
            VideoGames(nameTitle: "mario", headImage: #imageLiteral(resourceName: "mario"), gameThumbnail: #imageLiteral(resourceName: "mario"), gameDescription: "Mario"),
            VideoGames(nameTitle: "batman", headImage: #imageLiteral(resourceName: "batman"), gameThumbnail: #imageLiteral(resourceName: "batman"), gameDescription: "Batman Arkham Knight"),
            VideoGames(nameTitle: "call", headImage: #imageLiteral(resourceName: "call"), gameThumbnail: #imageLiteral(resourceName: "call"), gameDescription: "Call of Duty"),
            VideoGames(nameTitle: "cyberpunk", headImage: #imageLiteral(resourceName: "cyberpunk"), gameThumbnail: #imageLiteral(resourceName: "cyberpunk"), gameDescription: "Cyberpunk 2077"),
            VideoGames(nameTitle: "forza", headImage: #imageLiteral(resourceName: "forza"), gameThumbnail: #imageLiteral(resourceName: "forza"), gameDescription: "Forza Horizon 4"),
            VideoGames(nameTitle: "half", headImage: #imageLiteral(resourceName: "half"), gameThumbnail: #imageLiteral(resourceName: "half"), gameDescription: "Half-Life"),
            VideoGames(nameTitle: "las2", headImage: #imageLiteral(resourceName: "las2"), gameThumbnail: #imageLiteral(resourceName: "las2"), gameDescription: "Last of Us 2"),
            VideoGames(nameTitle: "metal", headImage: #imageLiteral(resourceName: "metal"), gameThumbnail: #imageLiteral(resourceName: "metal"), gameDescription: "Metal Gear Solid V Phantom Pain"),
            VideoGames(nameTitle: "splinter", headImage: #imageLiteral(resourceName: "splinter"), gameThumbnail: #imageLiteral(resourceName: "splinter"), gameDescription: "Splinter Cell Blacklist"),
            VideoGames(nameTitle: "street", headImage: #imageLiteral(resourceName: "street"), gameThumbnail: #imageLiteral(resourceName: "street"), gameDescription: "Street Fighter V"),
            VideoGames(nameTitle: "uncharted", headImage: #imageLiteral(resourceName: "uncharted"), gameThumbnail: #imageLiteral(resourceName: "uncharted"), gameDescription: "Uncharted 4 A Thief's End"),
            VideoGames(nameTitle: "last", headImage: #imageLiteral(resourceName: "last"), gameThumbnail: #imageLiteral(resourceName: "last"), gameDescription: "Last of Us Remastered"),
            VideoGames(nameTitle: "vice", headImage: #imageLiteral(resourceName: "vice"), gameThumbnail: #imageLiteral(resourceName: "vice"), gameDescription: "Grand Theft Auto Vice City"),
            VideoGames(nameTitle: "witcher", headImage: #imageLiteral(resourceName: "witcher"), gameThumbnail: #imageLiteral(resourceName: "witcher"), gameDescription: "The Witcher 3 Wild Hunt"),
            VideoGames(nameTitle: "zelda", headImage: #imageLiteral(resourceName: "zelda"), gameThumbnail: #imageLiteral(resourceName: "zelda"), gameDescription: "Zelda")
        ]]
}
