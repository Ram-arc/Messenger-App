//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Ram Kaluri on 06/07/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileTableView: UITableView!
    
    var items = ["log out","settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

       
    }
    

   

}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
        do{
            
           try FirebaseAuth.Auth.auth().signOut()
            
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
            
        }
        catch{
            
            print("failed to logout")
        }
        
    }
        
        
        else if indexPath.row == 1{
            print("selected settings")
            
        }
    }
    
   
    
    
}
