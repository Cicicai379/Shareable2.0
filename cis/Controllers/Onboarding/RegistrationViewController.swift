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

    private let titleText:UILabel = {
        let text = UILabel()
        let attributedString = NSMutableAttributedString(string: "Sign up")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 38), range: NSRange(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        return text
    }()
    
    private let usernameField:UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
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
        let showButton = UIButton(type: .custom)
        showButton.tintColor = .black
        showButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        showButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = showButton
        field.rightViewMode = .always

        return field
    }()

    @objc private func togglePasswordVisibility() {
        passwordField.isSecureTextEntry.toggle()
        let buttonImage = passwordField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        (passwordField.rightView as? UIButton)?.setImage(buttonImage, for: .normal)
    }
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Register",for:.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        let color = UIColor(red: 97/255, green: 29/255, blue: 53/255, alpha: 1.0)
       
        button.backgroundColor = color
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
        view.addSubview(titleText)

//        view.addSubview(privacyButton)
//
//        view.addSubview(termsButton)
//        view.addSubview(headerView)
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleText.frame = CGRect(x: view.width/3.0,
                                 y: view.height-view.safeAreaInsets.bottom-725,
                                    width:view.width - 20,
                                    height: 50.0)
        usernameField.frame = CGRect(x: 20,
                                     y: 80+view.safeAreaInsets.top+20,
                                     width: view.width - 40,
                                     height: 52.0)
        emailField.frame = CGRect(x: 20,
                                         y:60+view.safeAreaInsets.top+20+52+30,
                                         width: view.width - 40,
                                         height: 52.0)
       passwordField.frame = CGRect(x: 20,
                                    y: 80+view.safeAreaInsets.top+144,
                                    width:view.width - 40,
                                    height: 52.0)

       registerButton.frame = CGRect(x: 20,
                                  y: 80+view.safeAreaInsets.top+206,                                  width:view.width - 40,
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
