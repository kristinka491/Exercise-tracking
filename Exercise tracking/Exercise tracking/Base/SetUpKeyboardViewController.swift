//
//  SetUpKeyboard.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 14.10.2022.
//

import Foundation
import UIKit

class SetUpKeyboardViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
    }

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = view.convert(keyboardSize, from: nil)
            if let textField = textField,
               keyboardFrame.intersects(textField.frame) {
                let spaceBetweenKeyboardAndTextField = textField.frame.maxY - keyboardFrame.origin.y + 20
                view.frame.origin.y -= spaceBetweenKeyboardAndTextField
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
