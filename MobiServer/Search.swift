//
//  Search.swift
//  MobiServer
//
//  Created by Chandan Singh on 07/05/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//

import Foundation


class Search {

    let title : String?
    let year : String?
    let imdbID: String? //this should be removed or refactored
    let type: String? //this should be removed or refactored
    let poster: String? //this should be removed or refactored

    init?(json:Dictionary<String, AnyObject>){
        self.title = json["Title"] as! String?
        self.year = json[ "Year"] as! String?
        self.imdbID = json["imdbID"] as! String?
        self.type = json[ "Type"] as! String?
        self.poster = json["Poster"] as! String?
    }
}
