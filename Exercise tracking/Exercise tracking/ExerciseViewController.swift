//
//  ViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 11.10.2022.
//

import UIKit
import Moya

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    private let networkManager = NetworkManager.shared
    private var exercises = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        loadData()
    }

    private func loadData() {
        let alertVC = showLoader()
        networkManager.exercise { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.exercises = model?.list?.reduce([], +) ?? []
            self?.tableView.reloadData()
        }
    }

    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: "exerciseCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseTableViewCell {
            cell.setUp(exercises[indexPath.row])

            return cell
        }
        return UITableViewCell()
    }
}

