//
//  PreparationViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class PreparationViewController: UIViewController {

    @IBOutlet weak var mashView: UITextView!
    @IBOutlet weak var hopsView: UITextView!
    @IBOutlet weak var fermLabel: UILabel!
    @IBOutlet weak var matLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
        
        // set label texts
        mashView.text = ""
        for m in recipe!.Mashing {
            mashView.text.append(String(format: "Ruhen bei %i °C für %i Minuten\n", m.Temp, m.Rest))
        }
        
        hopsView.text = ""
        for h in recipe!.Hopping {
            hopsView.text.append(String(format: "%@ nach %i Minuten\n", h.Name, h.Time))
        }
        
        fermLabel.text = String(format: "%i Tage bei %i °C", recipe!.Fermentation.Weeks, recipe!.Fermentation.Temp)
        
        matLabel.text = String(format: "%i Tage bei %i °C", recipe!.Maturation.Duration, recipe!.Maturation.Temp)
    }
}
