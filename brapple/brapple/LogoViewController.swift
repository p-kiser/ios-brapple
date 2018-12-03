//
//  LogoViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {
    
    // TODO: JSON-Rezept erstellen nach folgender Vorlage:
    // https://craftbeer-revolution.de/lexikon/bier-selber-brauen/india-pale-rezept
    // Datentypen: siehe RecipeViewController
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func spinnerButton(_ sender: UIButton) {
        logo.transform = logo.transform.rotated(by: CGFloat(Double.pi / 4))
    }

    // TODO: fake loading bar and/or splash screen effect
}

