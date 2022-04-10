//
//  DetailViewController.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 8.03.2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var unFavButton: UIButton!
    
    var id: Int = 0
    var game = GameDetail(id: 0, name: "", background_image: "", metacritic: 0, description_raw: "", released: "", rating: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        game = getGameId(id: id)
        name?.text = game.name
        desc.text = game.description_raw
        rate.text = String(game.metacritic)
        date.text = game.released
        do {
            let url = URL(string: game.background_image)
            let data = try Data(contentsOf: url!)
            gameImage.image = UIImage(data: data)
        }
        catch {
            print("Resim bulunamadı.")
        }
        let check = checkFavoriteGames(id: id)
        
        if check == true {
            unFavButton.alpha = 1
            favButton.alpha = 0
        } else {
            unFavButton.alpha = 0
            favButton.alpha = 1
        }
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let favItem = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        favItem.setValue(id, forKey: "id")
        favItem.setValue(true, forKey: "isFavorite")
        favItem.setValue(game.name, forKey: "name")
        favItem.setValue(game.background_image, forKey: "background_image")
        favItem.setValue(game.released, forKey: "released")
        favItem.setValue(game.rating, forKey: "rating")
        
        do {
            try context.save()
            unFavButton.alpha = 1
            favButton.alpha = 0
        } catch {
            print("Eklenemedi...")
        }
    }
    
    @IBAction func unFavButtonTapped(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let getRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let verification = NSPredicate(format: "id == \(id)")
        getRequest.predicate = verification
        let result = try? context.fetch(getRequest)
        let resultData = result as! [Favorite]
        
        for object in resultData {
            context.delete(object)
        }
        do {
            try context.save()
            unFavButton.alpha = 1
            favButton.alpha = 0
            print("Eklendi.")
        } catch let error as NSError {
            print("Kaydedilemedi \(error), \(error.userInfo)")
        }
    }
func getGameId(id: Int) -> GameDetail {
    let api = "13a009d708da4805a552de5cec5b2908"
    let url = "https://api.rawg.io/api/games/\(id)?key=\(api)"
    
    guard let url = URL(string: url) else {
        fatalError("Geçersiz URL")
    }
    let game = try? JSONDecoder().decode(GameDetail.self, from: Data(contentsOf: url))
    
    guard let game = game else { fatalError("No Data") }
    self.game = game

    return game
}

func checkFavoriteGames(id: Int) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    let getRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
    let verification = NSPredicate(format: "id == \(id)")
    getRequest.predicate = verification
    let result = try? context.fetch(getRequest)
    let resultData = result as! [Favorite]
    
    if resultData.count > 0 {
        return true
    } else {
        return false
        }
    }
}
