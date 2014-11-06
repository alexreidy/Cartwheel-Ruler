//
//  Util.swift
//  Cartwheel Ruler
//
//  Created by Alex Reidy on 10/30/14.
//  Copyright (c) 2014 Alex Reidy. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

func now() -> Int { return time(nil) } // Current UNIX timestamp

func say(text: String) {
    var u = AVSpeechUtterance(string: text)
    u.voice = AVSpeechSynthesisVoice(language: "en-US")
    u.rate  = 0.25 * AVSpeechUtteranceMaximumSpeechRate
    AVSpeechSynthesizer().speakUtterance(u)
    println(text)
}

func vibrate() {
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
}

// Returns true if strB in strA
func contains(strA: String, strB: String) -> Bool {
    if (countElements(strA) < countElements(strB)) ||
        countElements(strA) == 0 || countElements(strB) == 0 {
        return false
    }
    
    var iB = 0
    
    for var i = 0; i < countElements(strA); i++ {
        if Array(strA)[i] == Array(strB)[iB] {
            if ++iB == countElements(strB) { return true }
        } else {
            iB = 0
        }
    }
    
    return false
}

func getDeviceHeightAndDepth() -> (height: Double?, depth: Double?) { // inches
    let deviceName = UIDeviceHardware.platformString()
    
    if contains(deviceName, "iPhone 4")      { return (4.54, 0.37) }
    if contains(deviceName, "iPhone 5C")     { return (4.9, 0.353) }
    if contains(deviceName, "iPhone 5")      { return (4.87, 0.30) }
    if contains(deviceName, "iPhone 6 Plus") { return (6.22, 0.28) }
    if contains(deviceName, "iPhone 6")      { return (5.44, 0.27) }
    if contains(deviceName, "iPad 2")        { return (9.50, 0.34) }
    if contains(deviceName, "iPad 3")        { return (9.50, 0.37) }
    if contains(deviceName, "iPad 4")        { return (9.50, 0.37) }
    if contains(deviceName, "iPad Mini")     { return (7.90, 0.30) }
    if contains(deviceName, "iPad Air 2")    { return (9.40, 0.24) }
    if contains(deviceName, "iPad Air")      { return (9.40, 0.29) }
    if contains(deviceName, "iPod Touch 5G") { return (4.86, 0.24) }
    
    return (nil, nil)
}