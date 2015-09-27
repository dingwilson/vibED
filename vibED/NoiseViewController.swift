//
//  NoiseViewController.swift
//  vibED
//
//  Created by Wilson Ding on 9/26/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import UIKit
import Firebase
import Charts

class NoiseViewController: UIViewController {
    
    let noiseRef = Firebase(url:"https://vibed.firebaseio.com/noise")
    
    var noiseArray : [FirebaseObject] = []
    
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
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
    
    func getData() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZ"
        
        noiseRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let stringDate = snapshot.value.objectForKey("date") as! String
            let date = dateFormatter.dateFromString(stringDate)
            let value = Int(snapshot.value.objectForKey("value") as! String)
            
            let newFirebaseObject = FirebaseObject(date: date!,value: value!)
            self.noiseArray.append(newFirebaseObject)
            self.refreshValues()
        })
    }
    
    func refreshValues () {
        
        var n = 0
        
        if(!noiseArray.isEmpty) {
            statusMessageLabel.text = "\(noiseArray[noiseArray.count-1].value())"
        }
        
        
        if Int(statusMessageLabel.text!) < 5 {
            statusMessageLabel.textColor = UIColor.greenColor()
        }
            
        else {
            statusMessageLabel.textColor = UIColor.redColor()
        }
        
        if(noiseArray.count > 10) {
            n = 10
        }
            
        else {
            n = noiseArray.count
        }
        
        if(!noiseArray.isEmpty) {
            let recentArray = noiseArray[(noiseArray.count-n)..<noiseArray.count]
            
            var recentDate : [String] = []
            var recentValue : [Double] = []
            
            for eachFirebaseObject in recentArray {
                recentDate.append("\(eachFirebaseObject.date())")
                recentValue.append(Double(eachFirebaseObject.value()))
            }
            
            setChart(recentDate, values: recentValue)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Noise")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
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
