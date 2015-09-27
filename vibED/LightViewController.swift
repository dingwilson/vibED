//
//  LightViewController.swift
//  vibED
//
//  Created by Wilson Ding on 9/26/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import UIKit
import Firebase
import Charts

class LightViewController: UIViewController {

    let lightRef = Firebase(url:"https://vibed.firebaseio.com/light")
    
    var lightArray : [FirebaseObject] = []
    
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
        
        lightRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let stringDate = snapshot.value.objectForKey("date") as! String
            let date = dateFormatter.dateFromString(stringDate)
            let value = Int(snapshot.value.objectForKey("value") as! String)
            
            let newFirebaseObject = FirebaseObject(date: date!,value: value!)
            self.lightArray.append(newFirebaseObject)
            self.refreshValues()
        })
    }
    
    func refreshValues () {
        
        var n = 0
        
        if(!lightArray.isEmpty) {
            statusMessageLabel.text = "\(lightArray[lightArray.count-1].value())"
        }
        
        if Int(statusMessageLabel.text!) < 5 {
            statusMessageLabel.textColor = UIColor.redColor()
        }
            
        else {
            statusMessageLabel.textColor = UIColor.greenColor()
        }
        
        if(lightArray.count > 10) {
            n = 10
        }

        else {
            n = lightArray.count
        }
        
        if(!lightArray.isEmpty) {
            let recentArray = lightArray[(lightArray.count-n)..<lightArray.count]
        
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

        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Light")
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
