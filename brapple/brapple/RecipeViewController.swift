//
//  RecipeViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

// Recipe struct
struct Recipe {
    let Name : String
    let Water : Float
    let Style : String
    let Malts : [(Name:String,Amount:Float)]
    let Hops : [(Name:String,Amount:Float)]
    let Yeast : [String]
    let Mashing : [(Temp:Int,Rest:Int)]
    let Hopping : [(Name:String,Time:Int)]
    let Fermentation : (Temp:Int, Weeks:Int)
    let Maturation : (Glucose:Int, Temp:Int, Duration: Int)
}

class RecipeViewController: UIViewController {
  
    // name of the chosen recipe
    var recipeId = ""
    // volume
    var volume : Float = 0.0
    // Brauwasser in Liter
    var water : Float = 0.0
    // recipe
    var recipe : Recipe?
    
    @IBOutlet weak var waterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // log stuff
        NSLog(">>> " + String(describing: type(of: self)))
        
        // water multiplication factor
        // TODO: Get this from the recipe
        water = 1.2
        // get recipe
        let urlString = "https://pkiser.com/brapple/" + recipeId + ".json"
        let url = URL(string: urlString)!
        let rawData = try! Data(contentsOf: url)
        let jsonData = try! JSONSerialization.jsonObject(with: rawData)
        
        // des json in eine datenstruktuer hineinwurschteln
        if let dict = jsonData as? [String : Any] {
            
            var malts : [(Name: String, Amount: Float)] = []
            for m in dict["Malts"] as! [String : NSNumber] {
                malts.append((Name: m.key, Amount: m.value.floatValue * volume))
            }
            var hops : [(Name:String, Amount:Float)] = []
            for h in dict["Hops"] as! [String : NSNumber] {
                hops.append((Name: h.key, Amount: h.value.floatValue * volume))
            }
            var mash : [(Temp: Int, Rest: Int)] = []
            for m in dict["Mashing"] as! [[Int]] {
                mash.append((Temp: m[0], Rest:m[1]))
            }
            var hopping : [(Name: String, Time: Int)] = []
            for h in dict["Hopping"] as! [String : NSNumber]{
                hopping.append((Name: h.key, Time: h.value.intValue))
            }
            var ferm : [Int] = []
            for f in dict["Fermentation"] as! Dictionary<String,Int> {
                ferm.append(f.value)
            }
            var mat : [Int] = []
            for m in dict["Maturation"] as! Dictionary<String,Int> {
                mat.append(m.value)
            }
            
            recipe = Recipe (
                Name: dict["Name"] as! String,
                Water: dict["Water"] as! Float,
                Style: dict["Style"] as! String,
                Malts: malts,
                Hops: hops,
                Yeast: dict["Yeast"] as! [String],
                Mashing: mash,
                Hopping: hopping,
                Fermentation: (ferm[0], ferm[1]),
                Maturation: (mat[0], mat[1], mat[2])
            )
            NSLog(recipe!.Name)
        }
        
        // show data
        // TODO: Make this prettier, as a table or whatever
        
        waterLabel.text = String(format: "%2.2f L", water * volume)
        
        for (index, m) in recipe!.Malts.enumerated() {
            let pos = index * 35 + 200
            let label = UILabel(frame: CGRect(x: 50, y: pos, width: 300, height: 60))
            label.text = String(format: "%3.2f kg\t%@", m.Amount, m.Name)
            self.view.addSubview(label)
        }
        for (index, h) in recipe!.Hops.enumerated() {
            let pos = index * 35 + 400
            let label = UILabel(frame: CGRect(x: 50, y: pos, width: 300, height: 60))
            label.text = String(format: "%4.2f g\t%@", h.Amount, h.Name)
            self.view.addSubview(label)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // pass the recipe to the next controller
    // TODO: Fix this. Make recipe globally accessible (singleton/instance of class Recipe or whatever)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PreparationViewController {
            let vc = segue.destination as? PreparationViewController
            vc?.recipe = self.recipe
        }
    }
}
