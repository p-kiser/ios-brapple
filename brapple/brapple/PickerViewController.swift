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
    @IBOutlet weak var continueButton: UIButton!
    
    // get list of recipes for picker
    let recipesUrl = URL(string:"https://pkiser.com/brapple/recipes.json")
    var beers : [(Id:String,Name:String)] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isHidden = true
        
        // list of beer to display
        self.beers = getRecipes()
        //set data source and delegate to self
        self.beerPicker.dataSource = self
        self.beerPicker.delegate = self
        
        // set volume text field to default value
        volumeSlider.value = volume
        volumeTextField.text = String(volumeSlider.value)
        
        if (UserDefaults.standard.string(forKey: "Id") != nil) {
            
            NSLog("Persisted Recipe found: %@, Water: %f L.",  UserDefaults.standard.string(forKey: "Id")!, UserDefaults.standard.float(forKey: "WaterVolume") )
            let beer = beers.first(where: {$0.Id == UserDefaults.standard.string(forKey: "Id")})
            let title = String(format: "Weitermachen mit: %@?", beer!.Name)
            
            continueButton.setTitle(title, for: UIControl.State.normal)
            continueButton.isHidden = false
        }
    }
    @IBAction func continuePressed(_ sender: UIButton) {
        recipeId = UserDefaults.standard.string(forKey: "Id")!
        volume = UserDefaults.standard.float(forKey: "WaterVolume")
        NSLog("Continue with persisted: %@, %f L.", recipeId, volume)
    }
    @IBAction func zutatenPressed(_ sender: UIButton) {
       let index : Int = beerPicker.selectedRow(inComponent: 0)
        recipeId = beers[index].Id
        volume = volumeSlider.value
        NSLog("Continue with user input: %@, %f L.", recipeId, volume)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getRecipes() -> [(Id:String, Name:String)] {
        
        var recipes : [(Id:String, Name:String)] = [];
        let rawData = try! Data(contentsOf: self.recipesUrl!)
        let jsonData = try! JSONSerialization.jsonObject(with: rawData)
        
        for item in jsonData as! [[String: Any]] {
            recipes.append((Id: item["id"] as! String, Name: item["name"] as! String))
        }
        return recipes;
    }
    
    //picker functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return beers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return beers[row].Name
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       recipeId = beers[row].Id
    }
    
    // volume slider and textfield functions
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volume = volumeSlider.value
        volumeTextField.text = String(format: "%.2f", sender.value)
    }
    @IBAction func volumeTextFieldChanged(_ sender: UITextField) {
        
        let text : String! = sender.text
        let volume : Float = Float(text) ?? 0.0
        volumeSlider.value = volume
    }
    
}

