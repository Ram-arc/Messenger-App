//
//  ViewController.swift
//  Messenger
//
//  Created by Ram Kaluri on 06/07/22.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class conversationsViewController: UIViewController {
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let noConverstaions : UILabel = {
        
        let label  = UILabel()
        label.text = "no conversations"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize : 21 , weight : .medium)
        label.isHidden = true
        return label
        
        
        
        
    }()
    
    
    private let tableview : UITableView = {
        
        
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose , target: self, action:#selector(didTapComposeButton)  )
        
        
        view.addSubview(tableview)
        view.addSubview(noConverstaions)
       
        
        fetchconverstionsfunc()
        setUpTableView()
        
      //  DatabaseManager.shared.test()
    }
    
    @objc private func didTapComposeButton(){
        
         let vc = NewConcersationViewController()
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc , animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
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
    
    private func setUpTableView(){
        
        tableview.delegate = self
        tableview.dataSource = self
        
        
        
    }
    
    private func fetchconverstionsfunc(){
        tableview.isHidden = false
        
    }

}

extension conversationsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = "Hello world"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let vc = chatViewController()
        vc.title = "jenny smith"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    
    
    
    
    
}



