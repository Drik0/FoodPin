//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 07/02/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    
    var restaurantImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       restaurantImageView.image = UIImage(named: restaurantImage)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
