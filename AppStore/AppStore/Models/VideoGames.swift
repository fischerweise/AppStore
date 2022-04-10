//
//  VideoGames.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 11.03.2022.
//

import UIKit

struct VideoGames: Hashable {
    let nameTitle: String
    let headImage: UIImage?
    let gameThumbnail: UIImage?
    let gameDescription: String?
    
    let gameUuid = UUID().uuidString
    
    init(nameTitle: String, headImage: UIImage? = nil, gameThumbnail: UIImage? = nil, gameDescription: String? = nil) {
        self.nameTitle = nameTitle
        self.headImage = headImage
        self.gameThumbnail = gameThumbnail
        self.gameDescription = gameDescription
}
func hash(int hasher: inout Hasher) {
    hasher.combine(gameUuid)
}

static func == (lhs: VideoGames, rhs: VideoGames) -> Bool {
    return lhs.gameUuid == rhs.gameUuid
    }
}
