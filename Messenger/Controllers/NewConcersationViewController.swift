//
//  NewConcersationViewController.swift
//  Messenger
//
//  Created by Ram Kaluri on 06/07/22.
//

import UIKit

class NewConcersationViewController: UIViewController {
  
    private let searchbar : UISearchBar = {
        
        let searchbar = UISearchBar()
        searchbar.placeholder = "search"
        return searchbar
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.titleView = searchbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
    }
    
    
     @objc private func didTapCancel(){
        
        dismiss(animated: true, completion: nil)
        
        
     }

 

}





extension conversationsViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    
    
    
    
}
