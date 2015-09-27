//
//  VibeViewController.swift
//  vibED
//
//  Created by Wilson Ding on 9/26/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import UIKit
import Firebase

class VibeViewController: UIViewController {
    
    let lightRef = Firebase(url:"https://vibed.firebaseio.com/light")
    let noiseRef = Firebase(url:"https://vibed.firebaseio.com/noise")
    let heatRef = Firebase(url:"https://vibed.firebaseio.com/heat")
    
    var lightArray : [FirebaseObject] = []
    var noiseArray : [FirebaseObject] = []
    var heatArray : [FirebaseObject] = []
    
    var goodStatusMessages = ["Helllll yeah!",
                              "Lookin' Good",
                              "Doin' Fine",
                              ":D"]
    
    var neutralStatusMessages = ["We could be doing better",
                                 "Meh",
                                 "Not great, but not terrible either..."]
    
    var badStatusMessages = ["Oops",
                             "I'm sorry...",
                             ":(",
                             "Running through the 6 with my woes"]

    @IBOutlet weak var statusMessageLabel: UILabel!
    
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var noiseLabel: UILabel!
    @IBOutlet weak var heatLabel: UILabel!
    
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var noiseButton: UIButton!
    @IBOutlet weak var heatButton: UIButton!
    
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    var isLightGood = true
    var isNoiseGood = true
    var isHeatGood = "green"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        refreshValues()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lightButtonPushed(sender: AnyObject) {
        tabBarController?.selectedIndex = 1
    }

    @IBAction func noiseButtonPushed(sender: AnyObject) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func heatButtonPushed(sender: AnyObject) {
        tabBarController?.selectedIndex = 3
    }
    
    func getData() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZ"
        
        lightRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let stringDate = snapshot.value.objectForKey("date") as! String
            let date = dateFormatter.dateFromString(stringDate)
            let value = Int(snapshot.value.objectForKey("value") as! String)
            
            if value < 5 {
                self.isLightGood = false
            }
            
            else {
                self.isLightGood = true
            }
            
            let newFirebaseObject = FirebaseObject(date: date!,value: value!)
            self.lightArray.append(newFirebaseObject)
            self.refreshValues()
        })
        
        noiseRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let stringDate = snapshot.value.objectForKey("date") as! String
            let date = dateFormatter.dateFromString(stringDate)
            let value = Int(snapshot.value.objectForKey("value") as! String)
            
            if value > 4 {
                self.isNoiseGood = false
            }
            
            else {
                self.isNoiseGood = true
            }
            
            let newFirebaseObject = FirebaseObject(date: date!,value: value!)
            self.noiseArray.append(newFirebaseObject)
            self.refreshValues()
        })
        
        heatRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let stringDate = snapshot.value.objectForKey("date") as! String
            let date = dateFormatter.dateFromString(stringDate)
            let value = Int(snapshot.value.objectForKey("value") as! String)
            
            if value > 90 {
                self.isHeatGood = "red"
            }
            
            else if value < 60 {
                self.isHeatGood = "red"
            }
            
            else if value > 80 {
                self.isHeatGood = "yellow"
            }
            
            else if value < 70 {
                self.isHeatGood = "yellow"
            }
            
            else {
                self.isHeatGood = "green"
            }
            
            let newFirebaseObject = FirebaseObject(date: date!,value: value!)
            self.heatArray.append(newFirebaseObject)
            self.refreshValues()
        })
    }
    
    func refreshValues () {
        
        
        if isLightGood {
            lightLabel.textColor = UIColor.greenColor()
        }
            
        else {
            lightLabel.textColor = UIColor.redColor()
        }
        
        if isNoiseGood {
            noiseLabel.textColor = UIColor.greenColor()
        }
            
        else {
            noiseLabel.textColor = UIColor.redColor()
        }
        
        if isHeatGood == "green"{
            heatLabel.textColor = UIColor.greenColor()
        }
            
        else if isHeatGood == "yellow"{
            heatLabel.textColor = UIColor.yellowColor()
        }
            
        else {
            heatLabel.textColor = UIColor.redColor()
        }
        
        if (isHeatGood == "green") && (isLightGood) && (isNoiseGood) {
            statusMessageLabel.textColor = UIColor.greenColor()
            let randomIndex = Int(arc4random_uniform(UInt32(goodStatusMessages.count)))
            statusMessageLabel.text = goodStatusMessages[randomIndex]
        }
            
        else if (isHeatGood == "yellow") && (isLightGood) && (isNoiseGood) {
            statusMessageLabel.textColor = UIColor.yellowColor()
            let randomIndex = Int(arc4random_uniform(UInt32(neutralStatusMessages.count)))
            statusMessageLabel.text = neutralStatusMessages[randomIndex]
        }
            
        else {
            statusMessageLabel.textColor = UIColor.redColor()
            let randomIndex = Int(arc4random_uniform(UInt32(badStatusMessages.count)))
            statusMessageLabel.text = badStatusMessages[randomIndex]
        }
        
        if(!lightArray.isEmpty) {
            lightButton.setTitle("\(lightArray[lightArray.count-1].value())", forState: UIControlState.Normal)
        }
        
        if(!noiseArray.isEmpty) {
            noiseButton.setTitle("\(noiseArray[noiseArray.count-1].value())", forState: UIControlState.Normal)
        }

        if(!heatArray.isEmpty) {
            heatButton.setTitle("\(heatArray[heatArray.count-1].value())", forState: UIControlState.Normal)
        }

        let date = NSDate();
        
        let formatter = NSDateFormatter();
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss a";
        formatter.timeZone = NSTimeZone.localTimeZone();
        
        let formattedDate = formatter.stringFromDate(date);
        
        lastUpdatedLabel.text = "Last Updated: \(formattedDate)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
