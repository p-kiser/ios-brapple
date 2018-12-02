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
    
    
    var beers : [String] =  [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // dummy data for testing
        beers = [
            "India Pale Ale",
            "Pilsner",
            "Berliner Weisse",
            "Bockbier",
            "Porter"
        ]
        // TODO: get picker data from JSON
        
        //set data source and delegate to self
        self.beerPicker.dataSource = self
        self.beerPicker.delegate = self
        
        // set volume text field to default value
        volumeSlider.value = 60
        volumeTextField.text = String(volumeSlider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        // Return a string from the array for this row.
        return beers[row]
    }
    
    // volume slider and textfield functions
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volumeTextField.text = String(format: "%.2f", sender.value)
    }
    @IBAction func volumeTextFieldChanged(_ sender: UITextField) {
        
        let text : String! = sender.text
        let volume : Float = Float(text) ?? 0.0
        // TODO: Min / Max value
        
        // TODO: slider = textfield value
        volumeSlider.value = volume
    }
    
}

