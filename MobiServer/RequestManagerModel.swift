//
//  URLConstants.swift
//  TheNewIndianExpress
//
//  Created by gaurav gupta on 26/03/17.
//  Copyright © 2017 ashiq. All rights reserved.
//

import Foundation

private let baseURL = "http://www.omdbapi.com"

enum serviceAPI {

	case allMovies(String)
    case movies(String)

	var URI: String {
		switch self {
		case .allMovies(let searchText):
            return "/?s=" + String(describing: searchText)
        case .movies(let movieId):
            return "/?i=" + String(movieId)
        }
	}
	var URL: String {
		switch self {
		case .allMovies:
            print(baseURL + self.URI)
			return baseURL + self.URI
	    case .movies:
            return baseURL + self.URI
        }
      }
}


