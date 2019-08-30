//
//  SearchLeagueViewController.swift
//  FDJ
//
//  Created by Danyl Semmache on 28/08/2019.
//  Copyright © 2019 Danyl Semmache. All rights reserved.
//

import UIKit
import Alamofire

struct leagueAllURL: Decodable {
    var strTeamBadge: String
}

class searchLeagueViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let leagueCollectionViewCellId = "LeagueCollectionViewCell"

    var leagues = [CellLeagueModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // make keyboard disapear
        keyboardDisapear()

        // create collectionView for league
        createLeagueCollectionView()
    }

    func keyboardDisapear() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    func callAPILeague(completion: @escaping(UIImage?) -> Void) {

        Alamofire.request

//        let leagueURL = URL(string: "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=French%20Ligue%201")
//
//        let allLeagueURL = URLSession.shared.dataTask(with: leagueURL!) { (data, response, error) in
//            DispatchQueue.main.async {
//                if error == nil {
//                    if data == nil {
//                    }
//                    do {
//                        var leagues = try JSONDecoder().decode([leagueAllURL].self, from: data!)
//
//                        for league in leagues {
//                            print(league.strTeamBadge)
//                        }
//                    } catch {
//                        print("error")
//                    }
//
////                    image = UIImage(data: data!)
////                    completion(image)
//                }
//            }
//        }
//        allLeagueURL.resume()



        var image: UIImage?
        let imageLeagueURL = URL(string: "https://www.thesportsdb.com/images/media/league/badge/0206v41534575321.png")!
        let imageLeagueTask = URLSession.shared.dataTask(with: imageLeagueURL) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if data == nil {
                    }
                    image = UIImage(data: data!)
                    completion(image)
                }
            }
        }
        imageLeagueTask.resume()
    }


    func createLeagueCollectionView() {
        // register cell
        let nibCell = UINib(nibName: leagueCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: leagueCollectionViewCellId)

        // init data
        for _ in 1...25 {
            guard let league = CellLeagueModel() else {
                return
            }
            callAPILeague() { (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                league.imageLeague = resultImage
                self.leagues.append(league)
                self.collectionView.reloadData()
            }
        }
    }
}

extension searchLeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagues.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.collectionView.frame.width/2.0) - 5 , height: (self.collectionView.frame.height/3.0))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leagueCollectionViewCellId, for: indexPath) as! LeagueCollectionViewCell
        let league = leagues[indexPath.row]
        cell.imageLeague.image = league.imageLeague
        return cell
    }
}
