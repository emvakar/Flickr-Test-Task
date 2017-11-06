//
//  CollectionViewCell.swift
//  Flickr Test Task
//
//  Created by Emil Karimov on 02.11.2017.
//  Copyright © 2017 Emil Karimov. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photo.image = nil
    }
    
    func configure(photo: Photo) {
        self.photo.sd_addActivityIndicator()
        self.photo.sd_setIndicatorStyle(.gray)
        self.photo.sd_setImage(with: URL(string: photo.url_o!), completed: nil)
    }
    
}
