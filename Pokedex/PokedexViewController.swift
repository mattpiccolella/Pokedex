//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Matt on 1/15/16.
//  Copyright © 2016 Matthew Piccolella. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PokedexViewController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!
  
    override func viewDidLoad() {
      super.viewDidLoad()

      collectionView.backgroundColor = UIColor.lightGrayColor()
      collectionView.delegate = self
      collectionView.dataSource = self
      
      self.automaticallyAdjustsScrollViewInsets = false

      self.navigationItem.title = "My Pokedex"
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }

}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(self.view.frame.width, 40.0)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 3.0
  }
}

extension PokedexViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("PokedexCell", forIndexPath: indexPath) as! PokedexCollectionViewCell
    newCell.nameLabel.text = "Pikachu"
    newCell.backgroundColor = UIColor.whiteColor()
    return newCell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
}