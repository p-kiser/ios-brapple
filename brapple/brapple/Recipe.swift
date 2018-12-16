//
//  Recipe.swift
//  brapple
//
//  Created by Pascal Kiser on 11/12/2018.
//  Copyright © 2018 bräpple. All rights reserved.
//
import UIKit


class Recipe : NSObject, NSCoding {
    
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

    // used for persisting
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: "Name")
        aCoder.encode(Water, forKey: "Water")
        aCoder.encode(Style, forKey: "Style")
        aCoder.encode(Malts, forKey: "Malts")
        aCoder.encode(Hops, forKey: "Hops")
        aCoder.encode(Yeast, forKey: "Yeast")
        aCoder.encode(Mashing, forKey: "Mashing")
        aCoder.encode(Hopping, forKey: "Hopping")
        aCoder.encode(Fermentation, forKey: "Fermentation")
        aCoder.encode(Maturation, forKey: "Maturation")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        self.init(Name: aDecoder.decodeObject(forKey: "Name") as! String,
                  Water: aDecoder.decodeFloat(forKey: "Water"),
                  Style: aDecoder.decodeObject(forKey: "Style") as! String,
                  Malts: aDecoder.decodeObject(forKey: "Malts") as! [(Name: String, Amount: Float)],
                  Hops: aDecoder.decodeObject(forKey: "Hops") as! [(Name: String, Amount: Float)],
                  Yeast: aDecoder.decodeObject(forKey: "Yeast") as! [String],
                  Mashing: aDecoder.decodeObject(forKey: "Mashing") as! [(Temp: Int, Rest: Int)],
                  Hopping: aDecoder.decodeObject(forKey: "Hopping") as! [(Name: String, Time: Int)],
                  Fermentation: aDecoder.decodeObject(forKey: "Fermentation") as! (Temp: Int, Weeks: Int),
                  Maturation: aDecoder.decodeObject(forKey: "Maturation") as! (Glucose: Int, Temp: Int, Duration: Int))
    }
    
    // init with json from url & volume from view
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

    init(
            Name: String,
            Water: Float,
            Style: String,
            Malts: [(Name:String,Amount:Float)],
            Hops: [(Name:String,Amount:Float)],
            Yeast: [String],
            Mashing: [(Temp:Int,Rest:Int)],
            Hopping: [(Name:String,Time:Int)],
            Fermentation: (Temp:Int, Weeks:Int),
            Maturation: (Glucose:Int, Temp:Int, Duration: Int)
        ) {
            self.Name = Name
            self.Water = Water
            self.Style = Style
            self.Malts = Malts
            self.Hops = Hops
            self.Yeast = Yeast
            self.Mashing = Mashing
            self.Hopping = Hopping
            self.Fermentation = Fermentation
            self.Maturation = Maturation
    }
    
}
