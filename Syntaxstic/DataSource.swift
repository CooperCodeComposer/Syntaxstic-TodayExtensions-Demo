//
//  DataSource.swift
//  Syntaxstic
//
//  Created by Alistair Cooper on 12/10/16.
//  Copyright © 2016 Alistair Cooper. All rights reserved.
//

import Foundation
import GameKit

struct DataSource {
    
    static var questions: [[String:String]] = [
        
        ["question": "In Swift 3 the first parameter at the function call site always has a parameter name unless you label it with what character?", "a": "-", "b":"_", "c": "^", "correct":"b"],
        
        ["question": "The new API guidelines in Swift 3 have led to: array.removeAtIndex(8) being renamed to what?", "a": "array.remove(at: 8)", "b":"array.removeAt(index: 8)", "c": "array.removeIndex(8)", "correct":"a"],
        
        ["question": "Enumeration cases previously began with uppercase letters. They now start with:", "a": "emojis", "b":"uppercase", "c": "lowercase", "correct":"c"],
        
        ["question": "Making UI changes on the main thread can now be made with the GDC call:", "a": "DispatchQueue.main.async{}", "b":"DispatchMom.ui.nowPlease{}", "c": "Dispatch.queue.async{}", "correct":"a"],
        
        ["question": "What is the method name for sorting an array in place?", "a": ".sortInPlace()", "b":".sorted()", "c": ".sort()", "correct":"c"],
        
        ["question": "Date, Calendar, URLSession etc.. have all dropped the NS prefix. What does NS stand for?", "a": "Next Step", "b":"New Step", "c": "No Surrender", "correct":"a"],
        
        ["question": "Date, Calendar, URLSession etc.. have all dropped the NS prefix. What does NS stand for?", "a": "Next Step", "b":"New Step", "c": "No Surrender", "correct":"a"],
        
        ["question": "What type is returned by array.joined(separator: \", \")", "a": "Tuple", "b":"String", "c": "[Int]", "correct":"b"]
    
    ]
    
    static func shuffleArray() {
        
        DataSource.questions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: DataSource.questions) as! [[String:String]]
    }
    
    
}
