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
    private var listOfExercises = [WorkoutItemModel]()
    private var filteredListOfExercises = [WorkoutItemModel]()
    private let networkManager = NetworkManager.shared
    private let numberOfCellsInRow = 2
    private let spaceBetweenCells = 0
    private let screenWidth = UIScreen.main.bounds.width
    private var selectedExercise: String?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpCollectionView()
        loadCollectionViewData()
        refreshTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTableViewData()
    }

    private func refreshTableView() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        self.loadTableViewData()
    }

    private func loadCollectionViewData() {
        let alertVC = showLoader()
        networkManager.exercise { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.exercises = model?.list?.reduce([], +) ?? []
            self?.collectionView.reloadData()
            self?.loadTableViewData()
        }
    }

    private func loadTableViewData() {
        let alertVC = showLoader()
        networkManager.workoutItem { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.refreshControl.endRefreshing()
            self?.listOfExercises = model?.list?.sorted(by: { $0.timestamp ?? 0 > $1.timestamp ?? 0 }).filter { $0.userId == currentUserId } ?? []
            if let selectedExercise = self?.selectedExercise {
                self?.filteredListOfExercises = self?.listOfExercises.filter { $0.name == selectedExercise } ?? []
                self?.tableView.reloadData()
            }
        }
    }

    private func deleteWorkoutItem(with id: Int) {
        let alertVC = showLoader()
        networkManager.deleteWorkout(id: id) { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            if model?.status == "ok" {
                if let index = self?.filteredListOfExercises.firstIndex(where: { $0.id == id }) {
                    self?.filteredListOfExercises.remove(at: index)
                    self?.tableView.reloadData()
                }

                if let index = self?.listOfExercises.firstIndex(where: { $0.id == id }) {
                    self?.listOfExercises.remove(at: index)
                }
            }
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
        return filteredListOfExercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath) as? WorkoutStatisticsTableViewCell {
            cell.setUpCell(filteredListOfExercises[indexPath.row])

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = filteredListOfExercises[indexPath.row].id {
                deleteWorkoutItem(with: id)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "WorkoutScreen", bundle: nil)
        if let workoutItemViewController = storyBoard.instantiateViewController(withIdentifier: "workoutScreen") as? WorkoutItemViewController {
            workoutItemViewController.setUp(with: filteredListOfExercises[indexPath.row], typeOfController: .edit)
            navigationController?.pushViewController(workoutItemViewController, animated: true)
        }
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedExercise = exercises[indexPath.row]
        filteredListOfExercises = listOfExercises.filter { $0.name == selectedExercise }
        tableView.reloadData()
    }
}
