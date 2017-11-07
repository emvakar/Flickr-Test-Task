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
    
    var datasource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Flickr Test Task"
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = datasource
        
        self.datasource.fetchRecent(page: 1) {
            self.collectionView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("orientation is: \(UIDevice.current.orientation.isPortrait ? "Portrait" : "Landscape")")
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (self.datasource.jsonArr.count - indexPath.row) <= 10 {
            self.datasource.fetchRecent(page: self.datasource.page, completion: {
                self.collectionView.reloadData()
            })
        }
    }
}




