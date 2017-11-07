//
//  DataSource.swift
//  Flickr Test Task
//
//  Created by Emil Karimov on 02.11.2017.
//  Copyright © 2017 Emil Karimov. All rights reserved.
//

import UIKit
import SwiftyJSON


class DataSource: NSObject, UICollectionViewDataSource {
    
    var jsonArr = [JSON]()
    var page: Int = 1
    var isLoading: Bool = false
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.jsonArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.configure(photo: Photo(json: self.jsonArr[indexPath.row])!)
        return cell
    }
    
    func fetchRecent(page: Int, completion: @escaping() -> Void) {
        if !self.isLoading {
            self.isLoading = true
            API.sharedInstance.getRecentPhoto(page: page, method: .getRecent, per_page: 25) { (jsonArr) in
                for photoJ in jsonArr {
                    if !(photoJ["url_n"].stringValue.isEmpty) && !(self.jsonArr.contains(photoJ)) {
                        self.jsonArr.append(photoJ)
                    }
                }
                self.isLoading = false
                self.page += 1
                completion()
            }
        }
    }
}

