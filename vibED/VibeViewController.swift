//
//  VibeViewController.swift
//  vibED
//
//  Created by Wilson Ding on 9/26/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import UIKit

class VibeViewController: UIViewController {
    
    var goodStatusMessages = ["Helllll yeah!",
                              "Lookin' Good",
                              "Doin' Fine",
                              ":D"]
    
    var neutralSTatusMessages = ["We could be doing better",
                                 "Meh",
                                 "Not great, but not terrible either..."]
    
    var badStatusMessages = ["Oops",
                             "I'm sorry...",
                             ":(",
                             "Running through the 6 with my woes"]

    @IBOutlet weak var statusMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomIndex = Int(arc4random_uniform(UInt32(goodStatusMessages.count)))
        statusMessageLabel.text = goodStatusMessages[randomIndex]
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
