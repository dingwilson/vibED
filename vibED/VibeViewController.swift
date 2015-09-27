//
//  VibeViewController.swift
//  vibED
//
//  Created by Wilson Ding on 9/26/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import UIKit

class VibeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
