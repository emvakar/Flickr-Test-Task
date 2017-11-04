//
//  MainViewController.swift
//  Flickr Test Task
//
//  Created by Emil Karimov on 02.11.2017.
//  Copyright © 2017 Emil Karimov. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 1
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var photos = [Photo]()
    var jsonArr = [JSON]()
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Flickr Test Task"
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        fetchRecent(page: page)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchRecent(page: Int) {
        API.sharedInstance.getRecentPhoto(page: page, method: .getRecent, per_page: 25) { (jsonArr) in
            for photoJ in jsonArr {
                if photoJ["url_n"].string != nil && !self.jsonArr.contains(photoJ) {
                    self.jsonArr.append(photoJ)
                }
            }
            self.photos = Photo.modelsFromJSON(jsonArr: self.jsonArr)
            self.collectionView.reloadData()
            self.page += 1
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("orientation is: \(UIDevice.current.orientation.isPortrait ? "Portrait" : "Landscape")")
        self.collectionView.reloadData()
    }
}




