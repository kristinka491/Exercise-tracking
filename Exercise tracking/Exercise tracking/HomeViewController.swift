//
//  HomeViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var myView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpView()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedGetStartedButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "ExerciseScreen", bundle: nil)
        let exerciseScreenViewController = storyBoard.instantiateViewController(withIdentifier: "exerciseScreen") as! ExerciseViewController
        navigationController?.pushViewController(exerciseScreenViewController, animated: true)
    }

//    private func setUpView() {
//        myView.layer.cornerRadius = 20
//        myView.layer.borderColor = UIColor.systemGray2.cgColor
//        myView.layer.borderWidth = 1
//    }
}
