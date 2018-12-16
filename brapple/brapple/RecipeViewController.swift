//
//  RecipeViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit


class RecipeViewController: UIViewController {
  
    @IBOutlet weak var titleBar: UINavigationBar!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var malzView: UITextView!
    @IBOutlet weak var hopfView: UITextView!
    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get recipe
        let urlString = "https://pkiser.com/brapple/" + recipeId + ".json"
        let url : URL = URL(string: urlString)!
        recipe = Recipe(url: url,volume: volume)
        NSLog("created recipe object" + recipe!.Name);
        // persist recipe
        UserDefaults.standard.set(url, forKey: "JsonUrl")
        UserDefaults.standard.set(recipeId, forKey: "Id")
        UserDefaults.standard.set(volume, forKey: "WaterVolume")
        NSLog("Persisted Data for: %@ with %f L", recipeId, volume)
        /*
        UserDefaults.standard.set(recipe, forKey: "recipe")
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: recipe)
        UserDefaults.standard.set(encodedData, forKey: "recipe")
        */
        UserDefaults.standard.synchronize()
        
        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
        
        // show data

        waterLabel.text = String(format: "%2.2f L", recipe!.Water)
        
        malzView.text = ""
        for m in recipe!.Malts {
            malzView.text.append(String(format: "%4.2f kg %@\n", m.Amount, m.Name))
        }
        
        hopfView.text = ""
        for h in recipe!.Hops {
            hopfView.text.append(String(format: "%4.2f g %@\n", h.Amount, h.Name))
        }
    }
}
