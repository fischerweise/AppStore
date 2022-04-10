//
//  ViewController.swift
//  AppStore
//
//  Created by Mustafa Pekdemir on 6.03.2022.
//

import UIKit
import CoreData

typealias GamesDataSource = UICollectionViewDiffableDataSource<GameManager.Section, VideoGames>

class ViewController: UIViewController {
    
    var games = listOfGames(next: "https://api.rawg.io/api/games?key=13a009d708da4805a552de5cec5b2908", results: [Game]())
    var gameList = [Game]()
    var filteredGames = [Game]()
    var isFiltering: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: GamesDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let next: String = ""
        games = getGames(next: next)
        gameList.append(contentsOf: games.results)
        tableView.dataSource = self
        
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100.0
        
        
        let moreButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.tableView.frame.width, height: 40)))
        moreButton.setTitle("Daha Fazla Yükle", for: .normal)
        moreButton.titleLabel?.textColor = .black
        moreButton.backgroundColor = .darkGray
        moreButton.addTarget(self, action: #selector(moreButtonClicked(_ :)), for: .touchUpInside)
        self.tableView.tableFooterView = moreButton
    }
    
    private func setupView() {
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.alwaysBounceVertical = false
        configureDataSource()
        configureSnapshot()
        collectionView.delegate = self
    }
    
    @objc func moreButtonClicked(_ sender: UIButton) {
        games = getGames(next: games.next)
        gameList.append(contentsOf: games.results)
        tableView.reloadData()
    }
    
    func getGames(next: String) -> listOfGames {
        let url: String
        let api = "13a009d708da4805a552de5cec5b2908"
        
        if next == "" {
            url = "https://api.rawg.io/api/games?key=\(api)&page=1"
        } else {
            url = next
        }
        
        guard let url = URL(string: url) else {
            fatalError("Geçersiz URL")
        }
        let gameList = try? JSONDecoder().decode(listOfGames.self, from: Data(contentsOf: url))
        guard let games = gameList else { fatalError("Veri Bulunamadı.")}
        self.games = games
        
        return games
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameDetail",
           let senderVC: DetailViewController = segue.destination as? DetailViewController {
            senderVC.id = sender as! Int
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGames.count
        }
        return games.results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell")
        let game: Game
        if isFiltering {
            game = filteredGames[indexPath.row]
        } else {
            game = games.results[indexPath.row]
        }
        
        cell?.textLabel?.text = game.name
        cell?.detailTextLabel?.text = "Değerlendirme:" + String(game.rating) + "Çıkış Tarihi:" + game.released
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell?.textLabel?.numberOfLines = 0
        
        do {
            let url = URL(string: game.background_image)
            let data = try Data(contentsOf: url!)
            cell?.imageView?.image = UIImage(data: data)
        } catch {
            print("Resim bulunamadı.")
        }
        
        cell?.imageView?.imageOptions()
        
        cell?.layer.borderWidth = 1.0
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.cornerRadius = 10
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gameDetail", sender: games.results[indexPath.row].id)
    }
}

extension UIImageView {
    func imageOptions() {
        let sizeOfItem = CGSize.init(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(sizeOfItem, false, UIScreen.main.scale);
        let image = CGRect.init(origin: CGPoint.zero, size: sizeOfItem)
        self.image!.draw(in: image)
        self.image = UIGraphicsGetImageFromCurrentImageContext()!
        self.layer.cornerRadius = (self.frame.height) / 2
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        UIGraphicsEndImageContext()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGames = games.results.filter({ (game: Game) -> Bool in
            return game.name.lowercased().contains(searchText.lowercased())
        })
        if filteredGames.count == 0 {
            tableView.setEmptyView(title: "Aradığınız kriterlerde oyun bulunamadı", message: "")
        }
        isFiltering = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.textColor = .white
        tableView.reloadData()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLine = UILabel()
        let messageLine = UILabel()
        titleLine.translatesAutoresizingMaskIntoConstraints = false
        messageLine.translatesAutoresizingMaskIntoConstraints = false
        titleLine.textColor = UIColor.black
        titleLine.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLine.textColor = UIColor.darkGray
        messageLine.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLine)
        emptyView.addSubview(messageLine)
        titleLine.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLine.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLine.topAnchor.constraint(equalTo: titleLine.bottomAnchor, constant: 20).isActive = true
        messageLine.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLine.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLine.text = title
        messageLine.text = message
        messageLine.numberOfLines = 0
        messageLine.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension ViewController {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var section: NSCollectionLayoutSection?
            switch sectionIndex {
            case 0:
                section = self.getHighlightSection()
            default:
                section = self.getHighlightSection()
            }
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func getHighlightSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}

extension ViewController {
    func configureDataSource() {
        dataSource = GamesDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, gameData: VideoGames) -> UICollectionViewCell? in
            let reuseIdentifier: String = HighlightCell.reuseIdentifier
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HighlightCell else {
                return nil
            }
            let section = GameManager.Section.allCases[indexPath.section]
            cell.showGame(showingGame: GameManager.gamesHighlights[section]?[indexPath.item])
            return cell
        }
    }
    
    func configureSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<GameManager.Section, VideoGames> ()
        GameManager.Section.allCases.forEach{ collection in
            currentSnapshot.appendSections([collection])
            if let gamesSnapshot = GameManager.gamesHighlights[collection] {
                currentSnapshot.appendItems(gamesSnapshot)
            }
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameSource = dataSource.itemIdentifier(for: indexPath)
        print(gameSource?.nameTitle ?? "Game Title is Nil.")
    }
}
