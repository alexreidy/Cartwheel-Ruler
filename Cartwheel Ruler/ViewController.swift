//
//  ViewController.swift
//  Cartwheel Ruler
//
//  Created by Alex Reidy on 10/4/14.
//  Copyright (c) 2014 Alex Reidy. All rights reserved.
//

//
// TODO
//
//
//

import UIKit

class ViewController: UIViewController {
    var ruler: Ruler! = nil
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var toggleMeasureButton: UIButton!
    
    @IBOutlet weak var instructionImageView: UIImageView!
    
    private var xAnchorValue: Double = 0
    private var timeLastAnchorSelected: Int? = nil
    
    // Array of functions that return current distance property values
    // Allows us to cycle through distance in different units
    var distanceInUnit: [(ruler: Ruler)->Double] = []
    
    let units = ["inches", "centimeters", "feet", "meters"]
    // Index for units[] and distanceInUnit[]
    var unit: Int = 3
    
    var distance: Double {
        get {
            return distanceInUnit[unit](ruler: ruler)
        }
    }
    
    var diststr: String {
        get {
            return String(format: "%.3f ", distance) + String(units[unit])
        }
    }
    
    @IBAction func onDistanceZoneTapped(sender: AnyObject) {
        if unit == distanceInUnit.count - 1 {
            unit = 0
        } else {
            unit++
        }
        distanceLabel.text = diststr
    }
    
    @IBAction func onToggleMeasureButtonTapped(sender: AnyObject) {
        toggleMeasuring()
    }
    
    func toggleMeasuring() {
        if ruler.measuring {
            ruler.stopMeasuring()
            toggleMeasureButton.setTitle("measure", forState: UIControlState.Normal)
        } else {
            if !ruler.startMeasuring(onRulerUpdate) {
                say("I can't access your accelerometer")
                return
            }
            toggleMeasureButton.setTitle("finish", forState: UIControlState.Normal)
        }
        timeLastAnchorSelected = nil
    }
    
    func onRulerUpdate() {
        if let x = ruler.x {
            distanceLabel.text = diststr
            if timeLastAnchorSelected == nil {
                timeLastAnchorSelected = now()
                xAnchorValue = x
            }
            if now() - timeLastAnchorSelected! > 4 {
                toggleMeasuring()
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.distanceLabel.text = self.diststr
                })
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    vibrate(); sleep(1)
                    say("All done; distance is " + self.diststr)
                })
                
            }
            if abs(x - xAnchorValue) > 0.2 {
                timeLastAnchorSelected = nil
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dimensions = getDeviceHeightAndDepth()
        
        if dimensions.height != nil && dimensions.depth != nil {
            ruler = Ruler(deviceHeight: dimensions.height!, deviceDepth: dimensions.depth!)
        } else {
            ruler = Ruler(deviceHeight: 0, deviceDepth: 0)
        }
        
        distanceInUnit = [
            {ruler in return ruler.inches},
            {ruler in return ruler.centimeters},
            {ruler in return ruler.feet},
            {ruler in return ruler.meters}
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}