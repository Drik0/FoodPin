//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Gerson Costa on 24/04/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
        contentLabel.text = content
    }

   
}
