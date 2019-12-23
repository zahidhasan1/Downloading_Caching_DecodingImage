//
//  PhotosCollectionViewController.swift
//  Downloading_Caching_DecodingImage
//
//  Created by ZEUS on 23/12/19.
//  Copyright © 2019 ZEUS. All rights reserved.
//

import UIKit



class PhotosCollectionViewController: UICollectionViewController {

    let reuseIdentifier = "PhotoCell"
    
    let photosManager = PhotosManager()
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    //MARK: - CollectionView Setup
    func registerCollectionViewCell(){
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosManager.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: photo(at: indexPath), photosManager: photosManager)
        return cell
    }
    
    func photo(at indexPath: IndexPath) -> Photo{
        let photos = photosManager.photos
        return photos[indexPath.row]
    }
}

//MARK: - CollectionView Flow Layout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let spacing : CGFloat = 0.5
        let width = (viewSize.width/2) - spacing
        let height = (viewSize.width/3) - spacing
        return CGSize(width: width, height: height)
    }
}
