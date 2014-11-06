//
//  Ruler.swift
//  Cartwheel Ruler
//
//  Created by Alex Reidy on 10/11/14.
//  Copyright (c) 2014 Alex Reidy. All rights reserved.
//

import Foundation
import CoreMotion

class Ruler: NSObject {
    
    private var timesHorizontal = 0
    
    // Master distance variable: the only one that is set directly
    var inches: Double {
        get {
            if let x = self.x {
                return Double(timesHorizontal) * (deviceHeight + deviceDepth) +
                    (dxCanIncrease ? x + deviceDepth : 0.0)
            }
            return 0
        }
    }
    
    var feet: Double {
        get {
            return inches / 12
        }
    }
    
    var centimeters: Double {
        get {
            return 2.54 * inches
        }
    }
    
    var meters: Double {
        get {
            return centimeters / 100
        }
    }
    
    private(set) var measuring = false
    
    private var onUpdate: () -> () = {}
    
    private let motionManager = CMMotionManager()
    
    private let loopInterval = 0.01 // seconds
    private var loopTimer: NSTimer! = nil
    
    private let deviceHeight = 4.87
    private let deviceDepth  = 0.3
    
    private var dxCanIncrease: Bool = true
    
    var y: Double? {
        get {
            if let data = motionManager.accelerometerData {
                var y = abs(data.acceleration.y)
                return y > 1 ? 1 : y
            }
            return nil
        }
    }
    
    var x: Double? {
        get {
            if let y = self.y {
                return sqrt(1 - pow(y, 2)) * deviceHeight
            }
            return nil
        }
    }
    
    init(deviceHeight: Double, deviceDepth: Double) {
        self.deviceHeight = deviceHeight
        self.deviceDepth = deviceDepth
    }
    
    func loop() {
        if !measuring { return }
        
        if let x = self.x {
            if dxCanIncrease && x > 0.999 * deviceHeight {
                dxCanIncrease = false
                timesHorizontal++
            }
        }
        
        if let y = self.y {
            // Device must pass through vertical for the change in x to count
            // because half the time the rotation is made just to catch up
            // to the current x position
            if y > 0.98 {
                dxCanIncrease = true
            }
        }
        
        if measuring { onUpdate() }
    }
    
    func startMeasuring(onUpdate: (() -> ())?) -> Bool {
        if !motionManager.deviceMotionAvailable {
            return false
        }
        
        dxCanIncrease = true
        timesHorizontal = 0
        
        if onUpdate != nil {
            self.onUpdate = onUpdate!
        }
        
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates()
        
        loopTimer = NSTimer.scheduledTimerWithTimeInterval(
            loopInterval, target: self, selector: Selector("loop"),
            userInfo: nil, repeats: true)
        
        measuring = true
        return true
    }
    
    func stopMeasuring() {
        loopTimer.invalidate()
        motionManager.stopAccelerometerUpdates()
        measuring = false
    }
    
}