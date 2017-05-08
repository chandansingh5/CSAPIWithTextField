//
//  Rating.swift
//  TheNewIndianExpress
//
//  Created by Chandan Singh on 07/05/17.
//  Copyright © 2017 ashiq. All rights reserved.
//

import Foundation


class Rating {
    
    let source : String?
    let value : String?
    
    init?(json: Dictionary<String, AnyObject>){
        self.source = json["Source"] as! String?
        self.value = json["Value"] as! String?
    }
}
