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
        UIImage(named: "tesla.JPG")!,
        UIImage(named: "pic.JPG")!,
        UIImage(named: "pic.PNG")!
    ]
    
    var slideShow: ImageSlideShowModel!

    @IBOutlet weak var instructionImageView: UIImageView!
    
    @IBOutlet var rightSwipeRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet var leftSwipeRecognizer: UISwipeGestureRecognizer!
    
    @IBAction func onImageSwipeRight(sender: AnyObject) {
        if let slide = slideShow.getPrevSlide() {
            instructionImageView.image = slide
        }
    }
    
    @IBAction func onImageSwipeLeft(sender: AnyObject) {
        if let slide = slideShow.getNextSlide() {
            instructionImageView.image = slide
        }
    }
    
    override func viewDidLoad() {
        slideShow = ImageSlideShowModel(slides: slideImages)
        if let slide = slideShow.getNextSlide() {
            instructionImageView.image = slide
        }
        rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Left
    }
    
}