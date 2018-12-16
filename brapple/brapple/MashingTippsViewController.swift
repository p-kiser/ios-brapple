//
//  MashingTippsViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class MashingTippsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display beer name and liters
        nameLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
    }
}
