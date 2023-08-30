//
//  LoginViewController.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let userManager = UserManager()
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func clearAllTextFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if validateFields() {
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            guard let user = userManager.get(byUsername: username) else {
                messageLabel.showWarningLabel(text: "This username does not exists. Consider making an account")
                return
            }
            
            if user.password != password {
                messageLabel.showWarningLabel(text: "Wrong password!")
                return
            }
            
            messageLabel.showSuccessLabel(text: "You have logged in!")
            messageLabel.hideLabelAfter(seconds: 2)
            clearAllTextFields()
            
            performSegue(withIdentifier: "ToTemperatureVC", sender: nil)
        }
    }
    
    
    func validateFields() -> Bool {
        guard let username = usernameTextField.text, username.isEmpty == false else {
            messageLabel.showWarningLabel(text: "Username field is empty")
            return false
        }
        
        guard let password = passwordTextField.text, password.isEmpty == false else {
            messageLabel.showWarningLabel(text: "Password field is empty")
            return false
        }
        
        return true
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageLabel.hideLabel()
    }
}
