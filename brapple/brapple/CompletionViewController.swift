//
//  CompletionViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class CompletionViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
    }
}
