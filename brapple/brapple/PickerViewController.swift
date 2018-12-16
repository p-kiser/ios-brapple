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
    
    // persisted data
    var persBeerId : String?
    var persWaterVol : Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isHidden = true
        
        // list of beer to display
        beers = getRecipes(url: recipesUrl!)
        //set data source and delegate to self
        beerPicker.dataSource = self
        beerPicker.delegate = self
        
        // set volume text field to default value
        volumeSlider.value = volume
        volumeTextField.text = String(volumeSlider.value)
        
        // get persisted recipe
        if (UserDefaults.standard.string(forKey: "Id") != nil) {
            persBeerId = UserDefaults.standard.string(forKey: "Id")!
            persWaterVol = UserDefaults.standard.float(forKey: "WaterVolume")
            
            let name = beers.first(where: { $0.Id == persBeerId })?.Name
            let title = String(format: "Weitermachen mit: %@?", name!)
            NSLog("Persisted Recipe found: %@, Water: %.2f L.",  persBeerId!, persWaterVol!)

            continueButton.setTitle(title, for: UIControl.State.normal)
            continueButton.isHidden = false
            
            // set input variables to default
            let index : Int = beerPicker.selectedRow(inComponent: 0)
            recipeId = beers[index].Id
            volume = volumeSlider.value
        }
    }
    @IBAction func continuePressed(_ sender: UIButton) {
        recipeId = persBeerId!
        volume = persWaterVol!
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
    
    func getRecipes(url : URL) -> [(Id:String, Name:String)] {
        
        var recipes : [(Id:String, Name:String)] = [];
        let rawData = try! Data(contentsOf: url)
        let jsonData = try! JSONSerialization.jsonObject(with: rawData)
        
        for item in jsonData as! [[String: String]] {
            recipes.append((Id: item["id"]! , Name: item["name"]!))
            NSLog("Added %@ to recipe list", item["id"]!)
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
        let beer = beers[row]
        NSLog("beers[i]: %@, Index: %i", beer.Id, row)
       recipeId = beer.Id
    }
    
    // volume slider and textfield functions
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volume = volumeSlider.value
        volumeTextField.text = String(format: "%.2f", sender.value)
    }
    @IBAction func volumeTextFieldChanged(_ sender: UITextField) {
        // input from text field disabled in free version
    }
    
}

