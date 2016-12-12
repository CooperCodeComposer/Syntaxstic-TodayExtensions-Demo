//
//  TodayViewController.swift
//  SyntaxsticWidget
//
//  Created by Alistair Cooper on 12/10/16.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var questions = [[String:String]]()
    var questionCounter = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        if let defaults = UserDefaults(suiteName: "group.com.alistaircooper.Syntaxstic") {
            
            if let storedQuestions = defaults.object(forKey: "Questions") as? [[String:String]] {
                questions = storedQuestions
            }
        }
        loadQuestion()
    }
    
    func loadQuestion() {
        
        questionCounter += 1
        
        if questionCounter == questions.count {
            questionCounter = 0
        }
        
        questionLabel.text = questions[questionCounter]["question"]
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            preferredContentSize = CGSize(width: 0, height: 130)
        } else {
            preferredContentSize = CGSize(width: 0, height: 240)
        }
    }
  
    
    @IBAction func showAction(_ sender: UIButton) {
        
        if let correctAnswer = questions[questionCounter]["correct"] {
            questionLabel.text = questions[questionCounter][correctAnswer]
        }
        
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        loadQuestion()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}
