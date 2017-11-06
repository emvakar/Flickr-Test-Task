//
//  API.swift
//  Flickr Test Task
//
//  Created by Emil Karimov on 02.11.2017.
//  Copyright © 2017 Emil Karimov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class API {
    
    static let sharedInstance = API()
    private let api_key = "786c663042abfeab83725e197cb3e207"
    
    struct Urls {
        static let baseUrl = "https://api.flickr.com/services/rest/"
    }
    
    enum Methods: String {
        case getRecent = "flickr.photos.getRecent"
    }
    
    func getRecentPhoto(page: Int, method: Methods, per_page: Int, completion: @escaping(_ jsonArr: [JSON]) -> Void) {
        let url = URL(string: Urls.baseUrl)!
        let parameters: Parameters = ["method": method.rawValue, "api_key": api_key, "extras": "url_n", "page": page, "per_page": per_page, "format": "json", "nojsoncallback": 1]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (responseJSON) in
            if responseJSON.result.isSuccess {
                if let data = responseJSON.data {
                    let json = JSON(data)
                    completion(json["photos"]["photo"].arrayValue)
                } else {
                    completion([])
                }
            }
        }
    }
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
