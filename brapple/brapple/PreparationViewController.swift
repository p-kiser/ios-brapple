//
//  PreparationViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class PreparationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // log stuff
        NSLog(">>> " + String(describing: type(of: self)))
    }
    
    // TODO Implement presentation of the choosen recipe as preparation steps
    // 1: 38°C 10 min.
    // 2: 60°C 20 min.
    // ...
}
