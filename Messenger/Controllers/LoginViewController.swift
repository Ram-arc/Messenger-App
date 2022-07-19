//
//  LoginViewController.swift
//  Messenger
//
//  Created by Vamsi krishna on 06/07/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MessengerLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailfield : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "email address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        
        return field
        
        
    }()
    
    
    private let passwordfield : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "password"
        field.isSecureTextEntry = true
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        
        
        return field
        
        
    }()

    
    private let scrollview : UIScrollView = {
        
        let scrollview = UIScrollView()
        scrollview.clipsToBounds = true
        return scrollview
        
    }()
    
    private let loginbutton : UIButton = {
        
        let loginbutton = UIButton(type: .system)
        
        loginbutton.setTitle("Login", for: .normal)
        loginbutton.backgroundColor = .link
        loginbutton.setTitleColor(.white, for: .normal)
        loginbutton.layer.cornerRadius = 12
        loginbutton.layer.masksToBounds = true
        loginbutton.titleLabel?.font = .systemFont(ofSize: 20 , weight :.bold)
        loginbutton.isUserInteractionEnabled = true
        
        
        return loginbutton
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Log-in"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        loginbutton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        //adding sub views
        view.addSubview(scrollview)
        scrollview.addSubview(imageView)
        scrollview.addSubview(emailfield)
        scrollview.addSubview(passwordfield)
        scrollview.addSubview(loginbutton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollview.frame = view.bounds
        let size = scrollview.frame.size.width/3
        
        
        imageView.frame = CGRect(x: 140, y:80, width: size, height: size)
        emailfield.frame = CGRect(x: 60, y:250, width: 300, height: 52)
        passwordfield.frame = CGRect(x: 60, y:340, width: 300, height: 52)
        loginbutton.frame = CGRect(x: 60, y:420, width: 300, height: 52)
    }
    
    @objc private func didTapRegister(){
        
        let vc = RegisterViewController()
        vc.title = "create account"
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    @objc private func didTapLogin(){
        
       guard let email = emailfield.text , let password = passwordfield.text,
             
             !email.isEmpty,!password.isEmpty,password.count >= 6 else {
        alertUserLogin()
         return
       }
     
        
        //firebase login
        // weak self for mpreventing memory leak
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {  [weak self]authResult , error in
            guard let strongself = self else{
                
                return
            }
            
            
            guard let result = authResult , error == nil  else {
                
                print("login failed \(email) ")
                
                return
                
                
            }
            
            let user = result.user
            print("logged in : \(user)")
            strongself.navigationController?.dismiss(animated: true, completion: nil)
            
            
        })
        
        
    }
    
    func alertUserLogin(){
        
        let alert = UIAlertController(title: "oops", message: "please enter details ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        present(alert , animated: true)
        
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
