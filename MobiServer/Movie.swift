//
//  Movie.swift
//  MobiServer
//
//  Created by Chandan Singh on 07/05/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//


import Foundation


class Movie{
    
    
    let title : String?
    let year : String?
    let rated : String?
    let released: String? 
    let genre: String? 
    let director: String?
    let writer : String?
    let actors : String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    var rating = [Rating]()
    let metascore : String?
    let imdbRating : String?
    let imdbVotes: String?
    let dVD: String?
    let boxOffice: String?
    let production: String?
    let imdbID: String?
    let type: String?
    let website: String?
    let response: String?

    init?(json: Dictionary<String, AnyObject>){

        self.title = json["Title"] as! String?
        let newArray = json["Ratings"] as! [Any]
        for item in newArray {
          self.rating.append(Rating.init(json: item as! Dictionary<String, AnyObject>)!)
        }
        self.metascore = json["Metascore"] as! String?
        self.imdbRating = json["imdbRating"] as! String?
        self.imdbVotes = json["imdbVotes"] as! String?
        self.dVD = json["DVD" ] as! String?
        self.boxOffice = json["BoxOffice"] as! String?
        self.production = json["Production" ] as! String?
        self.imdbID = json["imdbID" ] as! String?
        self.type = json["Type" ] as! String?
        self.website = json["Website" ] as! String?
        self.response = json["Response" ] as! String?
        self.year = json["Year" ] as! String?
        self.rated = json["Rated" ] as! String?
        self.released = json["Released" ] as! String?
        self.genre = json["Genre" ] as! String?
        self.director = json["Director" ] as! String?
        self.writer = json["Writer" ] as! String?
        self.actors = json["Actors" ] as! String?
        self.plot = json["Plot"] as! String?
        self.awards = json["Awards"] as! String?
        self.poster = json["Poster" ] as! String?
        self.language = json["Language" ] as! String?
        self.country = json["Country" ] as! String?
    }
    
}
