//
//  HomeViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var legsRaisesLabel: UILabel!
    @IBOutlet weak var pullUpsLabel: UILabel!
    @IBOutlet weak var pushUpsLabel: UILabel!
    @IBOutlet weak var tabataLabel: UILabel!

    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    @IBAction func tappedGetStartedButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "ExerciseScreen", bundle: nil)
        let exerciseScreenViewController = storyBoard.instantiateViewController(withIdentifier: "exerciseScreen") as! ExerciseViewController
        navigationController?.pushViewController(exerciseScreenViewController, animated: true)
    }

    private func loadData() {
        let alertVC = showLoader()
        networkManager.workoutItem { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.setUpLabel(with: model?.list)
        }
    }

    private func setUpLabel(with models: [WorkoutItemModel]?) {
        if let currentUserWorkoutItems = models?.filter({ $0.userId == currentUserId }) {
            Exercise.allCases.forEach { exercise in
                let exerciseIteration = currentUserWorkoutItems.filter { ($0.name ?? "") == exercise.rawValue }
                                                                .reduce(0, { $0 + ($1.iterationsCount ?? 0) })
                switch exercise {
                case .legsRaises:
                    legsRaisesLabel.text = "\(exerciseIteration)"
                case .pullUps:
                    pullUpsLabel.text = "\(exerciseIteration)"
                case .pushUps:
                    pushUpsLabel.text = "\(exerciseIteration)"
                case .tabata:
                    tabataLabel.text = "\(exerciseIteration)"

                }
            }
        }
    }
}
