//
//  ViewController.swift
//  Messenger
//
//  Created by Vamsi krishna on 06/07/22.
//

import UIKit
import FirebaseAuth

class conversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
      //  DatabaseManager.shared.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
        
       
    }

    
     private func validateAuth(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
            
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav , animated: false)
            
        }
        
        
    }

}

