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
  var filteredData: [PokemonModel] = []
  @IBOutlet var searchBar: UISearchBar!

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
    
    searchBar.delegate = self
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
          self.filteredData = self.pokemonData
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
    let pokemonModel = filteredData[indexPath.row]
    newCell.nameLabel.text = pokemonModel.name.capitalizedString
    newCell.backgroundColor = UIColor.whiteColor()
    return newCell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredData.count
  }
}

extension PokedexViewController: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detailController: PokemonDetailViewController = storyboard.instantiateViewControllerWithIdentifier("PokemonDetail") as! PokemonDetailViewController
    detailController.resourceURI = filteredData[indexPath.row].resourceURI
    self.navigationController?.pushViewController(detailController, animated: true)
  }
}

extension PokedexViewController: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    filteredData = pokemonData.filter({ (pokemon: PokemonModel) -> Bool in
      return pokemon.name.hasPrefix(searchText.lowercaseString) || searchText == ""
    })
    collectionView.reloadData()
  }
}