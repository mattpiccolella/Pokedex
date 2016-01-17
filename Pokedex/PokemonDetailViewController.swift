//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Matt on 1/16/16.
//  Copyright © 2016 Matthew Piccolella. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

  @IBOutlet var image: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var attackLabel: UILabel!
  @IBOutlet var defenseLabel: UILabel!
  @IBOutlet var movesList: UICollectionView!
  
  var resourceURI: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
