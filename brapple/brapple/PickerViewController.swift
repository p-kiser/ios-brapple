//
//  PickerViewController.swift
//  brapple
//
//  Created by Pascal Kiser on 27/11/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
    // UI elements
    @IBOutlet weak var beerPicker: UIPickerView!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var volumeSlider: UISlider!
    
    let recipesUrl = URL(string:"https://pkiser.com/brapple/recipes.json")
    var recipeId = ""
    var volume : Float = 10.0
    var beers : [(Id:String,Name:String)] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // log stuff
        NSLog(">>> " + String(describing: type(of: self)))

        beers = getRecipes()
        
        //set data source and delegate to self
        self.beerPicker.dataSource = self
        self.beerPicker.delegate = self
        
        // set volume text field to default value
        volumeSlider.value = volume
        volumeTextField.text = String(volumeSlider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getRecipes() -> [(Id:String, Name:String)] {
        
        var recipes : [(Id:String, Name:String)] = [];
        let rawData = try! Data(contentsOf: self.recipesUrl!)
        let jsonData = try! JSONSerialization.jsonObject(with: rawData)
        
        for item in jsonData as! [[String:String]] {
            recipes.append((Id: item["id"]!, Name: item["name"]!))
        }
        return recipes;
    }
    
    //picker functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Column count: use one column.
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        // Row count: rows equals array length.
        return beers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.recipeId = beers[row].Id
        // Return a string from the array for this row.
        return beers[row].Name
        
    }
    
    // volume slider and textfield functions
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volume = volumeSlider.value
        volumeTextField.text = String(format: "%.2f", sender.value)
    }
    @IBAction func volumeTextFieldChanged(_ sender: UITextField) {
        
        let text : String! = sender.text
        let volume : Float = Float(text) ?? 0.0
        // TODO: Min / Max value
        // TODO: slider = textfield value
        volumeSlider.value = volume
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeViewController {
            let vc = segue.destination as? RecipeViewController
            
            NSLog("Selected beer: " + recipeId)
            NSLog("Volume in L : " + String(volume))
            vc?.volume = self.volume
            vc?.recipeId = self.recipeId
        }
    }
}

