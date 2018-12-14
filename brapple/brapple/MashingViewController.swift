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
    let mashingProcesses = [
        [10, 0],
        [60, 300],
        [72, 120]]
    var currentMashingProcess : Int = 0
    var mashingProcessLabels : [UILabel] = []
    
    var isTimerRunning = false
    var timer = Timer()
    var timeInSeconds = 0

    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // log stuff
        NSLog(String(describing: type(of: self)))
        
        if isKeyPresentInUserDefaults(key: "mashingTimerKey") {
            self.timeInSeconds = UserDefaults.standard.object(forKey: "mashingTimerKey") as? Int ?? 0
        } else {
            self.timeInSeconds = self.mashingProcesses[self.currentMashingProcess][1]
        }
        
        if isKeyPresentInUserDefaults(key: "mashingProcessKey") {
            self.currentMashingProcess = UserDefaults.standard.object(forKey: "mashingProcessKey") as? Int ?? 0
        } else {
            self.currentMashingProcess = 0
        }
        
        addLabels()
        updateHighlight()
    }
    
    func addLabels() {
        var i = 0
        for(_, mashingProcess) in mashingProcesses.enumerated() {
            let label = UILabel(frame: CGRect(x: -2, y: 200+i*48, width: 380, height: 50))
            label.text = NSString(format:"%d°C\t%ds", mashingProcess[0], mashingProcess[1]) as String
            label.textAlignment = .center
            label.layer.borderWidth = 2.0
            label.layer.zPosition = 0
            self.view.addSubview(label)
            self.mashingProcessLabels.append(label)
            i += 1
        }
    }
    
    func updateHighlight() {
        if self.currentMashingProcess < self.mashingProcesses.count {
            self.view.bringSubviewToFront(self.mashingProcessLabels[self.currentMashingProcess]);
            self.mashingProcessLabels[self.currentMashingProcess].textColor = UIColor.green
            self.mashingProcessLabels[self.currentMashingProcess].layer.borderColor = UIColor.green.cgColor
        }
        if self.currentMashingProcess > 0 {
            self.mashingProcessLabels[self.currentMashingProcess - 1].textColor = UIColor.black
            self.mashingProcessLabels[self.currentMashingProcess - 1].layer.borderColor = UIColor.black.cgColor
            
        }
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        if self.isTimerRunning == false {
            self.isTimerRunning = true
            runTimer()
        } else {
            self.isTimerRunning = false
            sender.setTitle("Timer starten", for: .normal)
            self.timer.invalidate()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if self.timeInSeconds < 1 {
            self.timer.invalidate()
            self.currentMashingProcess += 1
            UserDefaults.standard.set(self.currentMashingProcess, forKey: "mashingProcessKey")
            if self.currentMashingProcess < self.mashingProcesses.count {
                self.timeInSeconds = self.mashingProcesses[self.currentMashingProcess][1]
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
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
