//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Matt on 1/16/16.
//  Copyright © 2016 Matthew Piccolella. All rights reserved.
//

import Foundation

class PokemonModel {
  
  var name: String!
  var resourceURI: String!
  
  init(name: String, resourceURI: String) {
    self.name = name
    self.resourceURI = resourceURI
  }

}
