//
//  LoginViewController.swift
//  share
//
//  Created by cici on 6/6/2023.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants{
        static let cornerRadius: CGFloat = 8.0
    }

    private let usernameEmailField:UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
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
    
//    private let passwordField:UITextField = {
//        let field = UITextField()
//        field.isSecureTextEntry=true
//        field.placeholder = "Password"
//        field.returnKeyType = .continue
//        field.leftViewMode = .always
//        field.leftView = UIView(frame: CGRect(x: 0, y:0, width:10, height:0))
//        field.autocapitalizationType = .none
//        field.autocorrectionType = .no
//        field.layer.masksToBounds = true
//        field.layer.cornerRadius = Constants.cornerRadius
//        field.layer.borderWidth = 1.0
//        field.layer.borderColor = UIColor.secondaryLabel.cgColor
//        field.backgroundColor = .secondarySystemBackground
//
//        return field
//    }()
//
//    private let showPassword:UIButton = {
//        let button = UIButton()
//        button.setTitle("show", for:.normal)
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = Constants.cornerRadius
//        button.addTarget(LoginViewController.self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
//        return button
//    }()
//    @objc private func togglePasswordVisibility() {
//        passwordField.isSecureTextEntry.toggle()
//        let buttonTitle = passwordField.isSecureTextEntry ? "show" : "hide"
//        showPassword.setTitle(buttonTitle, for: .normal)
//    }
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y:0, width: 10, height: 0))
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
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Log In",for:.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        let color = UIColor(red: 97/255, green: 29/255, blue: 53/255, alpha: 1.0)
       
        button.backgroundColor = color
        
//        button.backgroundColor = UIColor(hex: "#610e10")
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let privacyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy",for:.normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let termsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service",for:.normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createAccountButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.label,for:.normal)
        button.setTitle("New User? Create an Account",for:.normal)
        return button
    }()
    
    private let headerView:UIView = {
        let header=UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image:UIImage(named:"Header"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    private let titleText:UILabel = {
        let text = UILabel()
        let attributedString = NSMutableAttributedString(string: "Login")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 40), range: NSRange(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameEmailField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)

        addSubviews()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        
        
        super.viewDidLayoutSubviews()

        usernameEmailField.frame = CGRect(x: 25,
                                          y: 15 + view.height/3.0,
                                          width: view.width - 50,
                                          height: 52.0)
        passwordField.frame = CGRect(x: 25,
                                     y: 15 + view.height/3.0 + 62,
                                     width:view.width - 50,
                                     height: 52.0)

        loginButton.frame = CGRect(x: 25,
                                   y: 15 + view.height/3.0 + 114 + 10,
                                   width:view.width - 50,
                                   height: 52.0)

        createAccountButton.frame = CGRect(x: 25,
                                    y: 15 + view.height/3.0 + 166 + 10,
                                    width:view.width - 50,
                                    height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                           y: view.height-view.safeAreaInsets.bottom-100,
                                    width:view.width - 20,
                                    height: 50.0)
        privacyButton.frame = CGRect(x: 10,
                                           y: view.height-view.safeAreaInsets.bottom-50,
                                    width:view.width - 20,
                                    height: 50.0)

        titleText.frame = CGRect(x: view.width/3.0+10,
                                 y: view.height-view.safeAreaInsets.bottom-600,
                                    width:view.width - 20,
                                    height: 50.0)
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headerView.subviews.first else{
            return
        }
        backgroundView.frame = headerView.bounds
        
        //add logo
        let imageView = UIImageView(image: UIImage(named:"text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame =  CGRect(x: headerView.width/4.0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width/2.0,
                                  height: headerView.height - view.safeAreaInsets.top)
    }
    
    
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(titleText)
    }

    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty,password.count >= 8 else{
                  return
              }
        // login functionality
        var username: String?
        var email:String?
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            //email
            email = usernameEmail
        }else{
            //username
            username = usernameEmail
        }
        AuthManager.shared.loginNewUser(username: username, email: email, password: password){success in
            DispatchQueue.main.async{
                if success{
                    //logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    //error
                    let alert = UIAlertController(title: "Log In Error", message: "Incorrect username, email or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Dismiss",style:.cancel, handler:nil))
                                    
                    self.present(alert,animated:true)
                }
            }
        }
        
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://google.com")else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)

        return
    }
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://google.com")else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
        return
    }
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(vc, animated: true)
        return
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == usernameEmailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
