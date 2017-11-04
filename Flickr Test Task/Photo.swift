//
//  Photo.swift
//  Flickr Test Task
//
//  Created by Emil Karimov on 02.11.2017.
//  Copyright © 2017 Emil Karimov. All rights reserved.
//

import SwiftyJSON

public class Photo {
    
	public var id : Int?
	public var owner : String?
	public var secret : String?
	public var server : Int?
	public var farm : Int?
	public var title : String?
	public var ispublic : Int?
	public var isfriend : Int?
	public var isfamily : Int?
	public var lastupdate : Int?
    public var url_o: String?
    public var height_o: Float
    public var width_o: Float

    public class func modelsFromJSON(jsonArr: [JSON]) -> [Photo] {
        var models: [Photo] = []
        for json in jsonArr {
            models.append(Photo(json: json)!)
        }
        return models
    }

	required public init?(json: JSON) {
		id = json["id"].int
		owner = json["owner"].string
		secret = json["secret"].string
		server = json["server"].int
		farm = json["farm"].int
		title = json["title"].string
		ispublic = json["ispublic"].int
		isfriend = json["isfriend"].int
		isfamily = json["isfamily"].int
		lastupdate = json["lastupdate"].int
        url_o = json["url_n"].string
        width_o = json["width_n"].stringValue.floatValue
        height_o = json["height_n"].stringValue.floatValue
	}
    
}
