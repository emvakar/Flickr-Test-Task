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
    let minimumLineSpacing: CGFloat = 0.0
    let minimumInteritemSpacing: CGFloat = 0.0
    
    var isLoading: Bool = false
    
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
        if self.isLoading == false {
            self.isLoading = true
            API.sharedInstance.getRecentPhoto(page: page, method: .getRecent, per_page: 25) { (jsonArr) in
                for photoJ in jsonArr {
                    if !(photoJ["url_n"].stringValue.isEmpty) && !(self.jsonArr.contains(photoJ)) {
                        let indexPath = IndexPath(item: self.jsonArr.count, section: 0)
                        self.jsonArr.append(photoJ)
                        self.collectionView.insertItems(at: [indexPath])
                    }
                }
                self.isLoading = false
                self.page += 1
            }
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("orientation is: \(UIDevice.current.orientation.isPortrait ? "Portrait" : "Landscape")")
        self.collectionView.reloadData()
    }
}




