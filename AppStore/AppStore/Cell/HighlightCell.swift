//
//  HighlightCell.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 11.03.2022.
//

import UIKit

class HighlightCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: HighlightCell.self)
    
    @IBOutlet weak var image: UIImageView!
    
    func showGame(showingGame: VideoGames?) {
        image.image = showingGame?.headImage
        
    }
}
