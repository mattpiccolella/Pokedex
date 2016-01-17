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
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
