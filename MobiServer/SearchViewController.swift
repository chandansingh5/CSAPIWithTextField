//
//  SearchViewController.swift
//  MobiServer
//
//  Created by Chandan Singh on 08/05/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var callback : (([Search]) -> Void)?
    var filteredData = [Search]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TableCell", for: indexPath) as UITableViewCell
        let search = filteredData[indexPath.row]
        cell.textLabel?.text = search.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // item should NOT be included
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)
    }
    
    func reload(){
        if let serchText = self.searchBar.text {
            let networkManager = RequestManager.networkManager
            networkManager.fetchAllMoviesListFromNetwork(searchText:serchText, completion: { (resultarray : [Search]?, chekOutPut : Bool) in
                if let newArray = resultarray {
                    self.filteredData = newArray
                }else{
                    self.filteredData.removeAll()
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        callback?(filteredData)
        _ = navigationController?.popViewController(animated: true)
    }
   
    // called when cancel button pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
}
