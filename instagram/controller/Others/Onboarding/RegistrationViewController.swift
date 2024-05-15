//
//  RegistrationViewController.swift
//  instagram
//
//  Created by yousef Elaidy on 09/12/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    struct constants{
        static let cornerRadius: CGFloat = 8.0
    }
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
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
    
    private let registerbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate=self
        emailField.delegate=self
        passwordfield.delegate=self
        addsubviews()        
        registerbutton.addTarget(self, action: #selector(didtabregisterbutton), for: .touchUpInside)
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        userNameField.frame=CGRect(x: 25, y: view.safeAreaInsets.top + 10, width: view.width - 50, height: 52.0)
        emailField.frame=CGRect(x: 25, y: userNameField.bottom + 10, width: view.width - 50, height: 52.0)
        passwordfield.frame=CGRect(x: 25, y: emailField.bottom + 10, width: view.width - 50, height: 52.0)
        registerbutton.frame=CGRect(x: 25, y: passwordfield.bottom + 10, width: view.width - 50, height: 52.0)
        
        
    }
    
    private func addsubviews(){
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordfield)
        view.addSubview(registerbutton)
     
    }
    
    @objc func didtabregisterbutton(){
        passwordfield.resignFirstResponder()
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        
        guard let username = userNameField.text , !username.isEmpty ,
              let email = emailField.text, !email.isEmpty,
              let password = passwordfield.text, !password.isEmpty , password.count >= 8 else{
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success{
                    self.dismiss(animated: true)
                }else{
                    
                }
            }
           
        }
    }

    

}

extension RegistrationViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        }else if textField == emailField{
            passwordfield.becomeFirstResponder()
        }
        else if   textField == passwordfield{
             didtabregisterbutton()
        }
        return true
    }
    
    
    
}
