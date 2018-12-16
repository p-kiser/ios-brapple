//
//  LogoViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

var recipeId : String = "test"
var recipe : Recipe?
var volume : Float = 10.0
var debug : Bool = true

class LogoViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var debugSwitch: UISwitch!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugSwitch.setOn(debug, animated: true)
        rotateLogo(rad: (-Double.pi / 4))
        
    }
    
    // logo rotation button
    @IBAction func spinnerButton(_ sender: UIButton) {
        rotateLogo(rad: (Double.pi / 4))
    }
    
    func rotateLogo(rad : Double) {
        logo.transform = logo.transform.rotated(by: CGFloat(rad))
    }
    @IBAction func imgeTransformButtonClicked(_ sender: UIButton) {
        backgroundImage.image = UIImage(named: "brad-wurst")
    }
    @IBAction func debugSwitchChanged(_ sender: Any) {
        debug = debugSwitch.isOn
        NSLog("Debug is " + String(debug))
    }
    
}

	
