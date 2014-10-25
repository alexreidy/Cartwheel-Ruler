//
//  InstructionViewController.swift
//  Cartwheel Ruler
//
//  Created by Alex Reidy on 10/24/14.
//  Copyright (c) 2014 Alex Reidy. All rights reserved.
//

import Foundation
import UIKit

class InstructionViewController: UIViewController {
    
    var slideImages: [UIImage] = [
        UIImage(named: "0.jpg")!,
        UIImage(named: "1.jpg")!,
        UIImage(named: "2.jpg")!,
        UIImage(named: "3.jpg")!,
        UIImage(named: "4.jpg")!,
        UIImage(named: "5.jpg")!,
        UIImage(named: "6.jpg")!,
    ]
    
    var slideShow: SlideShowModel!

    @IBOutlet weak var instructionImageView: UIImageView!
    
    @IBOutlet var rightSwipeRecognizer: UISwipeGestureRecognizer!
    @IBAction func onImageSwipeRight(sender: AnyObject) {
        if let slide = slideShow.getPrevSlide() {
            instructionImageView.image = slide
        }
    }
    
    @IBOutlet var leftSwipeRecognizer: UISwipeGestureRecognizer!
    @IBAction func onImageSwipeLeft(sender: AnyObject) {
        if let slide = slideShow.getNextSlide() {
            instructionImageView.image = slide
        }
    }
    
    override func viewDidLoad() {
        rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        
        slideShow = SlideShowModel(slides: slideImages)
        
        if let slide = slideShow.getNextSlide() {
            instructionImageView.image = slide
        }
        
        say("Welcome to Cartwheel Ruler")
    }
    
}