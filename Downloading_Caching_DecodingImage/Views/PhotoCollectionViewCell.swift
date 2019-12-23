//
//  PhotoCollectionViewCell.swift
//  Downloading_Caching_DecodingImage
//
//  Created by ZEUS on 23/12/19.
//  Copyright © 2019 ZEUS. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var captionLabel: UILabel!
    
    weak var photosManager: PhotosManager?
    var request: Request?
    var photo: Photo!
    
    func configure (with photo: Photo, photosManager: PhotosManager){
        self.photo = photo
        self.photosManager = photosManager
        reset()
        loadImage()
    }
    
    func reset(){
        imageView.image = nil
        request?.cancel()
        captionLabel.isHidden = true
    }
    
    func loadImage(){
        
        if let image = photosManager?.cachedImage(for: photo.url){
            populate(with: image)
            return
        }
        downloadImage()
    }
    
    func downloadImage(){
        loadingIndicator.startAnimating()
        request = photosManager?.retriveImage(for: photo.url, completion: { (image) in
                 self.populate(with: image)
             })
    }
    
    func populate(with image: UIImage){
        loadingIndicator.stopAnimating()
        imageView.image = image
        captionLabel.text = photo.name
        captionLabel.isHidden = false
    }
    

}
