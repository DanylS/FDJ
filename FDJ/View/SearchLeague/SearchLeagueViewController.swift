//
//  SearchLeagueViewController.swift
//  FDJ
//
//  Created by Danyl Semmache on 28/08/2019.
//  Copyright © 2019 Danyl Semmache. All rights reserved.
//

import UIKit

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

    func callAPILeague() -> UIImage? {
        var image: UIImage?
        let imageLeagueURL = URL(string: "https://www.thesportsdb.com/images/media/league/badge/0206v41534575321.png")!

        let task = URLSession.shared.dataTask(with: imageLeagueURL) { (data, response, error) in
            if error == nil {
                image = UIImage(data: data!)
            }
        }
        task.resume()
        return image
    }

    func createLeagueCollectionView() {
        // register cell
        let nibCell = UINib(nibName: leagueCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: leagueCollectionViewCellId)

        // init data
        for _ in 1...25 {
            if let league = CellLeagueModel() {
                league.imageLeague = callAPILeague()
                leagues.append(league)
            }
            collectionView.reloadData()
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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = 10
        return UIEdgeInsets(top: CGFloat(inset), left: CGFloat(inset), bottom: CGFloat(inset), right: CGFloat(inset))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leagueCollectionViewCellId, for: indexPath) as! LeagueCollectionViewCell
        let league = leagues[indexPath.row]
        cell.imageLeague.image = league.imageLeague
        return cell
    }
}
