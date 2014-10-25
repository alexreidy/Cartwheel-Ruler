//
//  ImageSlideShowModel.swift
//  Cartwheel Ruler
//
//  Created by Alex Reidy on 10/24/14.
//  Copyright (c) 2014 Alex Reidy. All rights reserved.
//

import Foundation
import UIKit

class SlideShowModel: NSObject {
    
    private var slides: [UIImage] = []
    
    private var slideIndex: Int = -1
    
    var slideImage: UIImage {
        get {
            return slides[slideIndex]
        }
    }
    
    init(slides: [UIImage]) { self.slides = slides }
    
    func getNextSlide() -> UIImage? {
        if slideIndex + 1 > slides.count - 1 {
            return nil
        }
        return slides[++slideIndex]
    }
    
    func getPrevSlide() -> UIImage? {
        if slideIndex - 1 < 0 { return nil }
        return slides[--slideIndex]
    }
    
}