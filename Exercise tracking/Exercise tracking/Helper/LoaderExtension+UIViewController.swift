//
//  LoaderExtension+UIViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 11.10.2022.
//

import Foundation
import UIKit

extension UIViewController {

    func showLoader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

        return alert
    }

    func dismissLoader(alert: UIAlertController) {
        alert.dismiss(animated: false, completion: nil)
    }
}
