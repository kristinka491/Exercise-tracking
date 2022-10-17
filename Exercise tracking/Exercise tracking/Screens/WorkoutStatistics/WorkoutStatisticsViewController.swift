//
//  WorkoutStatisticsViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 17.10.2022.
//

import UIKit

class WorkoutStatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    private var exercises = [String]()
    private let networkManager = NetworkManager.shared
    private let numberOfCellsInRow = 2
    private let spaceBetweenCells = 15
    private let screenWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpCollectionView()
        loadExercisesData()
    }

    private func loadExercisesData() {
        let alertVC = showLoader()
        networkManager.exercise { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.exercises = model?.list?.reduce([], +) ?? []
            self?.collectionView.reloadData()
        }
    }

    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WorkoutStatisticsTableViewCell", bundle: nil), forCellReuseIdentifier: "statisticsCell")
    }

    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "ExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "exerciseCollectionCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath) as? WorkoutStatisticsTableViewCell {
//            cell.setUp(exercises[indexPath.row])

            return cell
        }
        return UITableViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCollectionCell", for: indexPath) as? ExerciseCollectionViewCell {
            cell.setUp(exercises[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Int(screenWidth) - spaceBetweenCells * (numberOfCellsInRow + 1)) / numberOfCellsInRow
        return CGSize(width: cellWidth, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
}
