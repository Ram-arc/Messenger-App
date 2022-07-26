//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Ram Kaluri on 06/07/22.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let imageview : UIImageView = {
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "userIcon")
        imageview.contentMode = .scaleAspectFill
        imageview.isUserInteractionEnabled = true
        imageview.layer.masksToBounds = true
        imageview.layer.borderWidth = 2
        imageview.layer.borderColor = UIColor.lightGray.cgColor
        
        
        return imageview
        
    }()
    
    private let firstname : UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "fist name...."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        
        
        return field
        
    }()
    
    private let lastname : UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "last name....."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        
        
        return field
        
    }()
    
    private let email : UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "email....."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        
        
        return field
        
    }()
    
    private let password : UITextField = {
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
    
    private let registerbutton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20 , weight :.bold)
        button.isUserInteractionEnabled = true
        
        return button
        
    }()
    
    private let scrollview : UIScrollView = {
     let scrollview = UIScrollView()
        scrollview.clipsToBounds = true
        scrollview.isUserInteractionEnabled = true
        return scrollview
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        registerbutton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        
        view.addSubview(scrollview)
        scrollview.addSubview(imageview)
        scrollview.addSubview(firstname)
        scrollview.addSubview(lastname)
        scrollview.addSubview(email)
        scrollview.addSubview(password)
        scrollview.addSubview(registerbutton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic)
        )
        
        imageview.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangeProfilePic(){
        print("tapped in image")
        presentPhotoActionSheet()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollview.frame = view.bounds
        let size = scrollview.frame.size.width/3
        
        imageview.frame = CGRect(x: 140, y: 80, width: size, height: size)
        
        imageview.layer.cornerRadius = 10
        
        firstname.frame = CGRect(x: 60, y: 250, width: 300, height: 52)
        lastname.frame = CGRect(x: 60, y: 340, width: 300, height: 52)
        email.frame = CGRect(x: 60, y: 420, width: 300, height: 52)
        password.frame = CGRect(x: 60, y: 500, width: 300, height: 52)
        registerbutton.frame = CGRect(x: 60, y: 580, width: 300, height: 52)
        
      
    }
    
    
    @objc func didTapRegister(){
        
        print("tapped register")
        
      
       
        
        
        guard
        let email = email.text ,
        let password = password.text,
            let firstname = firstname.text,
            let lastname = lastname.text,
              
              !email.isEmpty,
        !password.isEmpty,
        !firstname.isEmpty,
        !lastname.isEmpty,
        
        
        password.count >= 6 else {
         print("alert")
          return
        }
        spinner.show(in: view)
        
        DatabaseManager.shared.userExists(with: email, completion: {exists in
            
            DispatchQueue.main.async {
                self.spinner.dismiss()
            }
             
            guard !exists else{
                //user already exists
                
                
                
                self.alertUserLogin(message : "email already exists . Try another one. ")
                
                return
                
            }
            
            
            
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self]authResult , error in
                
                guard let strongself = self else {
                    
                    return
                }
                
                guard let result = authResult ,  error == nil else{
                    print("error creating account")
                    return
                    
                }
               
                let user = result.user
                print("created user: \(user)")
                
                let chatUser =  chatAppuser(firstName: firstname, lastName: lastname, emailAddress: email)
                DatabaseManager.shared.insertUser(with: chatUser , completion: {success in
                    
                    if success {
                        
                        //upload image
                        guard let image = self?.imageview.image , let data = image.pngData() else{
                            
                            return
                        }
                        
                        let fileName = chatUser.profilePictureFileName
                        StorageManager.shared.uploadprofileImage(with: data, filename: fileName, completion: {result in
                            
                            switch result {
                            case .success(let downloadUrl) : print(downloadUrl)
                                UserDefaults.standard.setValue(downloadUrl, forKey: "profile_picture_url")
                                
                            
                            case .failure(let error): print("storage manager error : \(error)")
                            
                            }
                            
                            
                        })
                        
                    }
                    
                    
                })
                
                strongself.navigationController?.dismiss(animated: true, completion: nil)
            })
            
        })
        
        
      
       
        
        
    }
    
    
    func alertUserLogin(message : String = ""){
        
        let alert = UIAlertController(title: "oops", message: message, preferredStyle: .alert)
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

extension RegisterViewController : UIImagePickerControllerDelegate  {
    
    
    func presentPhotoActionSheet(){
        
        let actionSheet = UIAlertController(title: "profile picture", message: "how do you want to upload the picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "take photo", style: .default, handler: { [weak self] _ in
            
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "choose photo", style: .default, handler: { [weak self] _ in
            
            self?.presentPhotopick()
        }))
        
        present(actionSheet, animated: true  )
        
    }
    
    func presentCamera(){
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc , animated: true)
        
    }
    func presentPhotopick(){
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc , animated: true)
        
        
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info)
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            
            return
        }
        
        imageview.image = selectedimage
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
