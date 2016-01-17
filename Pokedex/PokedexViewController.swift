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
  var pokemonData: [PokemonModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = UIColor.lightGrayColor()
    collectionView.delegate = self
    collectionView.dataSource = self
      
    self.automaticallyAdjustsScrollViewInsets = false

    self.navigationItem.title = "My Pokedex"
    
    fetchData("http://pokeapi.co/api/v1/pokedex/1/", completion: {
      self.collectionView.reloadData()
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func fetchData(url: String, completion: () -> Void) {
    Alamofire.request(.GET, url, encoding: .JSON).responseData { response in
      switch response.result {
      case .Success(_):
        let responseData: JSON = JSON(data: response.data!)
        if let pokemon = responseData["pokemon"].array {
          self.pokemonData = pokemon.map({ (json: JSON) -> PokemonModel in
            PokemonModel(name: json["name"].string!, resourceURI: json["resource_uri"].string!)
          })
        }
      case .Failure(let error):
        self.pokemonData = []
        print(error)
      }
      completion()
    }
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
    let pokemonModel = pokemonData[indexPath.row]
    newCell.nameLabel.text = pokemonModel.name.capitalizedString
    newCell.backgroundColor = UIColor.whiteColor()
    return newCell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemonData.count
  }
}