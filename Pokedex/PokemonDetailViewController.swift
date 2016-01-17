//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Matt on 1/16/16.
//  Copyright © 2016 Matthew Piccolella. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PokemonDetailViewController: UIViewController {

  @IBOutlet var image: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var attackLabel: UILabel!
  @IBOutlet var defenseLabel: UILabel!
  @IBOutlet var movesList: UICollectionView!
  
  var resourceURI: String!
  var moves: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    movesList.delegate = self
    movesList.dataSource = self
    movesList.backgroundColor = UIColor.lightGrayColor()

    fetchPokemonData(resourceURI) { (pokemonData: JSON) -> Void in
      self.nameLabel.text = pokemonData["name"].string
      self.attackLabel.text = String(format: "Attack: %d", pokemonData["attack"].int!)
      self.defenseLabel.text = String(format: "Defense: %d", pokemonData["defense"].int!)
      let imageURL = String(format: "http://pokeapi.co/media/img/%d.png", pokemonData["pkdx_id"].int!)
      self.loadAndSetImage(imageURL)
      let movesArray: [JSON] = pokemonData["moves"].array!
      self.moves = movesArray.map({ (json: JSON) -> String in
        json["name"].string!
      })
      self.movesList.reloadData()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func fetchPokemonData(resourceURI: String, completion: (JSON) -> Void) {
    Alamofire.request(.GET, "http://pokeapi.co/" + resourceURI, encoding: .JSON).responseData { response in
      switch response.result {
      case .Success(_):
        let pokemonData: JSON = JSON(data: response.data!)
        completion(pokemonData)
      case .Failure(let error):
        print(error)
      }
    }
  }
  
  func loadAndSetImage(url: String) {
    if let pictureURL = NSURL(string: url) {
      if let data = NSData(contentsOfURL: pictureURL) {
        image.image = UIImage(data: data)
      }
    }
  }

}

extension PokemonDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(self.view.frame.width, 30.0)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 3.0
  }
}

extension PokemonDetailViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("MoveCell", forIndexPath: indexPath) as! MoveCollectionViewCell
    newCell.moveName.text = moves[indexPath.row]
    newCell.backgroundColor = UIColor.whiteColor()
    return newCell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return moves.count
  }
}
