//
//  Recipe.swift
//  brapple
//
//  Created by Pascal Kiser on 11/12/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//
import UIKit

class Recipe {
    
    var Name : String
    var Water : Float
    var Style : String
    var Malts : [(Name:String,Amount:Float)]
    var Hops : [(Name:String,Amount:Float)]
    var Yeast : [String]
    var Mashing : [(Temp:Int,Rest:Int)]
    var Hopping : [(Name:String,Time:Int)]
    var Fermentation : (Temp:Int, Weeks:Int)
    var Maturation : (Glucose:Int, Temp:Int, Duration: Int)
    
    // json from url, volume from view
    init(url : URL, volume : Float) {
        
        // try to get recipe from url
        let rawData = try! Data(contentsOf: url)
        let jsonData = try! JSONSerialization.jsonObject(with: rawData)
        
        // get data
        let dict = jsonData as! [String : Any]
        self.Name = dict["Name"] as! String
        Water = Float(dict["Water"] as! NSNumber) * volume
        Style = dict["Style"] as! String
        Malts = []
        for m in dict["Malts"] as! [String : NSNumber] {
            Malts.append((Name: m.key, Amount: m.value.floatValue * volume))
        }
        Hops = []
        for h in dict["Hops"] as! [String : NSNumber] {
            Hops.append((Name: h.key, Amount: h.value.floatValue * volume))
        }
        Yeast = dict["Yeast"] as! [String]
        Mashing = []
        for m in dict["Mashing"] as! [[Int]] {
            Mashing.append((Temp: m[0], Rest:m[1]))
        }
        Hopping = []
        for h in dict["Hopping"] as! [String : NSNumber]{
            Hopping.append((Name: h.key, Time: h.value.intValue))
        }
        var ferm : [Int] = []
        for f in dict["Fermentation"] as! Dictionary<String,Int> {
            ferm.append(f.value)
        }
        Fermentation = (Temp: ferm[0], Weeks: ferm[1])
        var mat : [Int] = []
        for m in dict["Maturation"] as! Dictionary<String,Int> {
            mat.append(m.value)
        }
        Maturation = (Glucose: mat[0], Temp: mat[1], Duration: mat[2])
        NSLog("Got json from URL: " + url.absoluteString)
    }
    
    // default init with test data
    init() {
        Name         = "Local Test Beer"
        Water        = 1.23
        Style        = "Test beer"
        Malts        = [("Test malt 1", 4), ("Test malt 2", 5)]
        Hops         = [("Test hops 1", 6), ("Test hops 2", 7)]
        Yeast        = ["Test yeast"]
        Mashing      = [(Temp:55, Rest:8),(Temp:65,9)]
        Hopping      = [("Test hops 1", Time:10), ("Test hops 2", Time: 60)]
        Fermentation = (Temp: 12, Weeks: 2)
        Maturation   = (Glucose: 5, Temp: 12, Duration: 21)
    }
}
