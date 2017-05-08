//
//  RequestManager.swift
//  TheNewIndianExpress
//
//  Created by ashiq on 25/03/17.
//  Copyright © 2017 ashiq. All rights reserved.
//

//MARK:- IMPORT MODULES
import Foundation

protocol RequestManagerDelegate {
    //  func responseData(service:serviceAPI, data: Any)
    func getDataCompleted()
}


//MARK:- REQUEST MANAGER
final class RequestManager{
    
    var delegate: RequestManagerDelegate?
    
    //MARK:- Class variable
    static let networkManager = RequestManager()
    
    //MARK:- Private Methods
    private init(){}
    
   
    fileprivate func fetchFromNetwork(forService service:serviceAPI,completion:@escaping (_ result:AnyObject,_ sucess:Bool) -> Void ){
        let callURL = URL.init(string:service.URL )
        let request = URLRequest.init(url:callURL!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let data = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    return completion(data as AnyObject,true)
                } else {
                    return completion(data as AnyObject,false)
                }
            }
        })
        task.resume()
    }
    
    func fetchAllMoviesListFromNetwork(searchText:String,completion:@escaping (_ result:[Search]?,_ sucess:Bool) -> Void ){
        let service = serviceAPI.allMovies(searchText)
        print(service.URL)
        self.fetchFromNetwork(forService:service) { (responseObject:AnyObject ,sucess:Bool) in
            if sucess{
                if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
                    guard let jsonData =  jsonResult["Search"] else {return}
                    let array = self.generateAllSearchObjects(from:jsonData as! [Any])
                    return completion(array,true)
                }else{
                    return completion(nil,false)
                }
            }else{
                return completion(nil,false)
            }
        }
    }
    
    func fetchMovies(moviesList:[Search],completion:@escaping (_ result:[Movie]?,_ sucess:Bool) -> Void ) {
        var listArray = [Movie]()
        let myGroup = DispatchGroup()
        for newSerch in moviesList {
            guard let imId =  newSerch.imdbID  else {return}
            myGroup.enter()
            self.fetchMoviesFromNetworkwithId(movieId:imId) { (response:Movie?,sucess:Bool) in
                if sucess{
                    guard response != nil  else {return}
                    listArray.append(response!)
                    myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: DispatchQueue.main, execute: {
            return completion(listArray,true)
        })
    }
    
    func fetchMoviesFromNetworkwithId(movieId:String,completion:@escaping (_ result:Movie?,_ sucess:Bool) -> Void ){
        let service = serviceAPI.movies(movieId)
        print(service.URL)
        self.fetchFromNetwork(forService:service) { (response:AnyObject ,sucess:Bool) in
            if sucess{
                let array = self.generateMovieObjects(from: response)
                return completion(array,true)
            }else{
                return completion(nil,false)
            }
        }
    }
    
    //MARK: Generate All Stories Object
    func generateAllSearchObjects(from toplevelObj:[Any]) -> [Search]? {
        var allSearchMovies  = [Search]()
        for item in toplevelObj {
            allSearchMovies.append(Search.init(json: item as! Dictionary<String, AnyObject>)!)
        }
        return allSearchMovies
    }
    
    //MARK: Generate All Stories Object
    func generateMovieObjects(from toplevelObj:Any) -> Movie? {
        let allMovies  = Movie.init(json: (toplevelObj as? Dictionary<String, AnyObject>)!)!
      return allMovies
    }
}

