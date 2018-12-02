//
//  RecipeViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    // Brauwasser in Liter
    var water : Float = 0.0
    // Malzsorten mit Mengenangaben (in kg)
    var malt : [(Float, String)] = []
    // Hopfensorten mit Mengenangaben (in g)
    var hops : [(Float, String)] = []
    
    @IBOutlet weak var waterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // dummy data
        water = 12.0
        malt = [
            (5.0, "Pale Ale Malz"),
            (1.0, "Münchner Malz hell"),
            (0.5, "Karamellmalz hell")
        ]
        hops = [
            (80.0, "Simcoe"),
            (80.0, "Amarillo"),
            (60.0, "Cascade"),
            (70.0, "Columbus")
        ]
        
        // show data
        waterLabel.text = String(format: "%i L", water)
        
        for (index, m) in malt.enumerated() {
            let pos = index * 35 + 200
            let label = UILabel(frame: CGRect(x: 50, y: pos, width: 300, height: 60))
            label.text = String(format: "%2.2f kg\t%@", m.0, m.1)
            self.view.addSubview(label)
        }
        for (index, m) in hops.enumerated() {
            let pos = index * 35 + 400
            let label = UILabel(frame: CGRect(x: 50, y: pos, width: 300, height: 60))
            label.text = String(format: "%.2f g\t%@", m.0, m.1)
            self.view.addSubview(label)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
