//
//  RegisterViewController.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let userManager = UserManager()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
    }
    
    func setDelegates() {
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if validateFields() {
            // Check if the user already exists.
            let username = usernameTextField.text!
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            if (userManager.checkIfExists(by: username)) {
                messageLabel.showWarningLabel(text: "A user with same username already exists!")
                return
            }
            
            // Create a new user and add to the data store
            let newUser = User(id: UUID(), email: email, username: username, password: password)
            userManager.create(newUser)
            
            messageLabel.textColor = .green
            messageLabel.showSuccessLabel(text: "New user has been created!")
            clearAllTextFields()
            messageLabel.hideLabelAfter(seconds: 2)
        }
    }
    
    func validateFields() -> Bool {
        guard let email = emailTextField.text, email.isEmpty == false else {
            messageLabel.showWarningLabel(text: "Email cannot be empty")
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) == false {
            messageLabel.showWarningLabel(text: "Not a valid email")
            return false
        }
        
        guard let username = usernameTextField.text, username.isEmpty == false else {
            messageLabel.showWarningLabel(text: "User name cannot be empty")
            return false
        }
        
        if username.contains(" ") {
            messageLabel.showWarningLabel(text: "Username cannot have spaces")
            return false
        }
        
        guard let password = passwordTextField.text, password.isEmpty == false else {
            messageLabel.showWarningLabel(text: "Password cannot be empty")
            return false
        }
        
        if password.count < 6 {
            messageLabel.showWarningLabel(text: "Password should contain atleast 6 characters")
            return false
        }
        
        return true
    }
    
    func clearAllTextFields() {
        emailTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageLabel.hideLabel()
    }
}
