//
//  LoginViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct constants{
        static let cornerRadius: CGFloat = 8.0
    }
    private let usernameemailfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        field.backgroundColor = .secondarySystemBackground
        
        
        return field
    }()
    
    private let passwordfield: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let loginbutton: UIButton = {
        let button = UIButton()
        button.setTitle("log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Serviced", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacy: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createanewaccount: UIButton = {
        let button = UIButton()
        button.setTitle("New user ? Create New Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerview: UIView = {
        let header = UIView()
        let backgroundimage = UIImageView(image: UIImage(named: "gradients"))
        header.addSubview(backgroundimage)
        return header
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameemailfield.delegate=self
        passwordfield.delegate=self
        addsubviews()
        view.backgroundColor = .systemBackground
        
        loginbutton.addTarget(self, action: #selector(didtabloginbutton), for: .touchUpInside)
        createanewaccount.addTarget(self, action: #selector(didtapnewaccountbutton), for: .touchUpInside)
        termsbutton.addTarget(self, action: #selector(didtaptermbutton
                                                     ), for: .touchUpInside)
        privacy.addTarget(self, action: #selector(didtapprivacybutton), for: .touchUpInside)

    }
    
    override func viewDidLayoutSubviews() {
        headerview.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height/3.0)
        usernameemailfield.frame=CGRect(x: 25, y: headerview.bottom + 40, width: view.width - 50, height: 52.0)
        passwordfield.frame=CGRect(x: 25, y: usernameemailfield.bottom + 10, width: view.width - 50, height: 52.0)
        loginbutton.frame=CGRect(x: 25, y: passwordfield.bottom + 10, width: view.width - 50, height: 52.0)
        createanewaccount.frame=CGRect(x: 25, y: loginbutton.bottom + 10, width: view.width - 50, height: 52.0)
        termsbutton.frame=CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width - 20, height: 50.0)
        privacy.frame=CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-50, width: view.width - 20, height: 50.0)
        
        
        configureheaderview()
    }
    
    private func configureheaderview(){
        guard headerview.subviews.count == 1 else{
            return
        }
        guard let backgroundview = headerview.subviews.first else{
            return
        }
        backgroundview.frame = headerview.bounds
        let imageview = UIImageView(image: UIImage(named: "text"))
        headerview.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.frame = CGRect(x: headerview.width/4.0, y: view.safeAreaInsets.top, width: headerview.width/2.0, height: headerview.height - view.safeAreaInsets.top)
    }
    
    private func addsubviews(){
        view.addSubview(usernameemailfield)
        view.addSubview(passwordfield)
        view.addSubview(loginbutton)
        view.addSubview(createanewaccount)
        view.addSubview(termsbutton)
        view.addSubview(privacy)
        view.addSubview(headerview)
        
    }
    
    @objc func didtabloginbutton(){
        passwordfield.resignFirstResponder()
        usernameemailfield.resignFirstResponder()
        
        guard let usernameEmail = usernameemailfield.text , !usernameEmail.isEmpty ,
              let password = passwordfield.text , !password.isEmpty , password.count >= 8 else{
            return
        }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@" ),usernameEmail.contains("." ){
            email = usernameEmail
        }else{
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password){ success in
            DispatchQueue.main.async {
                if success{
                   
                        self.dismiss(animated: true)
                    
                }else{
                   
                        let alert = UIAlertController(title: "login error", message: "we are unable to log you in.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel))
                        self.present(alert, animated: true)
                    
                  
                }
            }
         
            
        }
        
        // login func
    }
    @objc func didtaptermbutton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870")else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc func didtapprivacybutton(){
        guard let url = URL(string: "https://help.instagram.com/contact/1676704782672605")else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didtapnewaccountbutton(){
        let vc = RegistrationViewController()
        vc.title="Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}


extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameemailfield {
            passwordfield.becomeFirstResponder()
        }else
        if   textField == passwordfield{
            didtabloginbutton()
        }
        return true
    }
    
    
    
}
