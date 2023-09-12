//
//  RegistrationViewController.swift
//  share
//
//  Created by cici on 7/6/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants{
        static let cornerRadius: CGFloat = 8.0
    }

    private let usernameField:UITextField = {
        let field = UITextField()
        field.placeholder = "Usrname"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y:0, width:10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let emailField:UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y:0, width:10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    private let passwordField:UITextField = {
        let field = UITextField()
        field.isSecureTextEntry=true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y:0, width:10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground

        return field
    }()
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Register",for:.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self

        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
//        view.addSubview(privacyButton)
//
//        view.addSubview(termsButton)
//        view.addSubview(headerView)
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top+20,
                                     width: view.width - 40,
                                     height: 52.0)
        emailField.frame = CGRect(x: 20,
                                         y: view.safeAreaInsets.top+20+52+10,
                                         width: view.width - 40,
                                         height: 52.0)
       passwordField.frame = CGRect(x: 20,
                                    y: view.safeAreaInsets.top+20+52+10 + 62,
                                    width:view.width - 40,
                                    height: 52.0)

       registerButton.frame = CGRect(x: 20,
                                  y: view.safeAreaInsets.top+206,                                  width:view.width - 40,
                                  height: 52.0)
    }
    
    
    @objc private func didTapRegister(){
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text,!password.isEmpty, password.count >= 8,
                let username = usernameField.text, !username.isEmpty else {
                    return
                }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password){registered in
            if registered {
                //good to go
            }else{
                //failed
            }
            
        }

    }

}


extension RegistrationViewController: UITextFieldDelegate{
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == usernameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
           didTapRegister()
        }
        return true
    }
}

