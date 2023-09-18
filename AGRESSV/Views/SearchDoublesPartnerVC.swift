//
//  SearchDoublesPartnerVC.swift
//  AGRESSV
//
//  Created by RyanMax OMelia on 9/9/23.
//

import UIKit
import Firebase
import FirebaseFirestore


class SearchDoublesPartnerVC: UIViewController {
    

   
    var UsernameArray = [String]()
    
 
    
  
    
    //let Usernames = ["user1", "user2", "user3"]
    var FilteredUsernames: [String]!
    

 
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilteredUsernames = UsernameArray

        TableView.delegate = self
        TableView.dataSource = self
    }
    

    
}

extension SearchDoublesPartnerVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilteredUsernames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = FilteredUsernames[indexPath.row]
        return cell
    }
    
   

    
}
