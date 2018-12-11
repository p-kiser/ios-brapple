//
//  LogoViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.transform = logo.transform.rotated(by: CGFloat(-Double.pi / 4))
    }
    
    @IBAction func spinnerButton(_ sender: UIButton) {
        logo.transform = logo.transform.rotated(by: CGFloat(Double.pi / 4))
    }
}

