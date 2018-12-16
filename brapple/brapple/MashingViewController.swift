//
//  MashingViewController.swift
//  brapple
//
//  Created by John Smith on 12/3/18.
//  Copyright © 2018 bräpple. All rights reserved.
//

import UIKit

class MashingViewController: UIViewController {
    
    // Temp in °C, Time in seconds
    var mashingProcesses = recipe!.Mashing
    
    var currentMashingProcess : Int = 0
    var mashingProcessLabels : [UILabel] = []
    
    var isTimerRunning = false
    var timer = Timer()
    var timeInSeconds = 0

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display beer name and liters
        topLabel.text = String(format: "%@, %.2f L", recipe!.Name, volume)
        
        // set debugging times
        if debug {
            for (i,_) in mashingProcesses.enumerated() {
                mashingProcesses[i].Rest = 3
            }
        }
        
        if isKeyPresentInUserDefaults(key: "mashingTimerKey") {
            self.timeInSeconds = UserDefaults.standard.object(forKey: "mashingTimerKey") as? Int ?? 0
        } else {
            self.timeInSeconds = self.mashingProcesses[self.currentMashingProcess].Rest
        }
 
        NSLog("Time in seconds: %i", timeInSeconds)
        
        if isKeyPresentInUserDefaults(key: "mashingProcessKey") {
            let m = UserDefaults.standard.integer(forKey: "mashingProcessKey")
            currentMashingProcess = m < mashingProcesses.count ? m : 0
        } else {
            self.currentMashingProcess = 0
        }
        NSLog("Current step: %i", currentMashingProcess)
        
        //addLabels()
        for (i, m) in self.mashingProcesses.enumerated() {
            let label = UILabel(frame: CGRect(x: -2, y: 200+i*48, width: 380, height: 50))
            label.text = String(format:"Bei %i °C für %i Sekunden ruhen lassen", m.Temp, m.Rest)
            label.textAlignment = .center
            label.layer.borderWidth = 2.0
            label.layer.zPosition = 0
            self.view.addSubview(label)
            self.mashingProcessLabels.append(label)
        }
        updateHighlight()
    }
    
    func updateHighlight() {
        for (i,label) in mashingProcessLabels.enumerated() {
            if i == self.currentMashingProcess {
                view.bringSubviewToFront(label)
                label.textColor = UIColor.green
                label.layer.borderColor = UIColor.green.cgColor
            } else {
                label.textColor = UIColor.black
                label.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        NSLog("timer button pressed")
        if isTimerRunning == false {
            isTimerRunning = true
            runTimer()
        } else {
            isTimerRunning = false
            sender.setTitle("Timer starten", for: .normal)
            timer.invalidate()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if self.timeInSeconds < 1 {
            self.timer.invalidate()
            self.currentMashingProcess += 1
            if currentMashingProcess >= mashingProcesses.count {
                timerButton.isEnabled = false
                timerButton.backgroundColor = UIColor.gray
            }
            UserDefaults.standard.set(self.currentMashingProcess, forKey: "mashingProcessKey")
            if self.currentMashingProcess < self.mashingProcesses.count {
                self.timeInSeconds = self.mashingProcesses[currentMashingProcess].Rest
                self.timerButton.setTitle("Timer starten", for: .normal)
                self.isTimerRunning = false
            } else {
                self.timerButton.isEnabled = false
            }
            updateHighlight()
        } else {
            self.timeInSeconds -= 1
            self.timerButton.setTitle(timeString(time: TimeInterval(self.timeInSeconds)), for: .normal)
        }
        UserDefaults.standard.set(self.timeInSeconds, forKey: "mashingTimerKey")
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func nextStep(_ sender: UIButton) {
        currentMashingProcess = 0
        UserDefaults.standard.set(self.currentMashingProcess, forKey: "mashingProcessKey")
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
