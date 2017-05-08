//
//  ViewController.swift
//  MobiServer
//
//  Created by Chandan Singh on 06/05/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!

    var filteredData = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchVc = segue.destination as! SearchViewController
        searchVc.callback = { message in
            self.fathcResult(message: message)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TableCell", for: indexPath) as UITableViewCell
        let source = filteredData[indexPath.row]
        cell.textLabel?.text = source.title
        if let _ = stringToURL(string: (source.poster)!){
            cell.imageView?.kf.setImage(with: stringToURL(string: (source.poster)!))
        }else{
            cell.imageView?.image = #imageLiteral(resourceName: "placeholder")
        }
        return cell
    }
    
    func stringToURL(string: String) -> URL? {
        return URL(string: string)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func fathcResult(message:[Search]) {
        
        let networkManager = RequestManager.networkManager
        networkManager.fetchMovies(moviesList: message, completion: { (resultarray : [Movie]?, chekOutPut : Bool) in
            if let newArray = resultarray {
                print(newArray)
                self.filteredData = newArray
                //  self.filteredData = newArray
            }
            self.tableView.reloadData()
        })
        
    }
}
