//
//  ViewController.swift
//  Syntaxstic
//
//  Created by Alistair Cooper on 12/10/16.
//  Copyright © 2016 Alistair Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var questionCounter = 0
    
    @IBOutlet weak var answerStack: UIStackView!
    
    @IBOutlet weak var questionStack: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var isCorrectLabel: UILabel!
    @IBOutlet weak var ans1Button: UIButton!
    @IBOutlet weak var ans2Button: UIButton!
    @IBOutlet weak var ans3Button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [NSFontAttributeName: UIFont(name:"Chalkduster", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        // shuffle array
        DataSource.shuffleArray()
        
        setInitialState()
        
        // save questions to user defaults
        if let defaults = UserDefaults(suiteName: "group.com.alistaircooper.Syntaxstic") {
            
            defaults.set(DataSource.questions, forKey: "Questions")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadQuestion()
    }
    
    func setInitialState() {
        
        answerStack.transform = CGAffineTransform(scaleX: 0.7, y: 0.0)
        answerStack.alpha = 0
        questionStack.alpha = 0
        isCorrectLabel.transform = CGAffineTransform(translationX: -300.0, y: 0.0)
        isCorrectLabel.alpha = 0
        
    }
    
    func loadQuestion() {
        
        questionCounter += 1
        
        if questionCounter == DataSource.questions.count {
            questionCounter = 0
        }
        
        let current = DataSource.questions[questionCounter]
        
        questionLabel.text = current["question"]
        ans1Button.setTitle(current["a"], for: .normal)
        ans2Button.setTitle(current["b"], for: .normal)
        ans3Button.setTitle(current["c"], for: .normal)
                
        let animation = UIViewPropertyAnimator(duration: 1.2, dampingRatio: 0.5) {
            self.answerStack.alpha = 1
            self.answerStack.transform = CGAffineTransform.identity
            self.questionStack.alpha = 1
        }
        
        animation.startAnimation()
        
        resetButtons()

    }
    
    func checkAnswer(answer: String) {
        
        let current = DataSource.questions[questionCounter]
        
        if current["correct"] == answer {
            isCorrectLabel.text = "CORRECT"
            isCorrectLabel.textColor = UIColor.green
        } else {
            isCorrectLabel.text = "INCORRECT"
            isCorrectLabel.textColor = UIColor.red
        }
        
        let animation = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.9) {
            self.isCorrectLabel.transform = CGAffineTransform.identity
            self.isCorrectLabel.alpha = 1
        }
        
        animation.startAnimation()
        
        highlightCorrectAnswer()
        
    }
    
    func highlightCorrectAnswer() {
        
        if let correct = DataSource.questions[questionCounter]["correct"] {
            
            switch correct {
            case "a":
                ans2Button.alpha = 0.3
                ans3Button.alpha = 0.3
            case "b":
                ans1Button.alpha = 0.3
                ans3Button.alpha = 0.3
            case "c":
                ans1Button.alpha = 0.3
                ans2Button.alpha = 0.3
            default: break
            }
            
        }
    }
    
    func disableButtons() {
        ans1Button.isEnabled = false
        ans2Button.isEnabled = false
        ans3Button.isEnabled = false
    }
    
    func resetButtons() {
        
        ans1Button.isEnabled = true
        ans2Button.isEnabled = true
        ans3Button.isEnabled = true
        
        ans1Button.alpha = 1
        ans2Button.alpha = 1
        ans3Button.alpha = 1
    }
    
    func resetAnimation() {
        
        let animation = UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut) {
            [unowned self] in
            self.answerStack.transform = CGAffineTransform(scaleX: 0.8, y: 0.0)
            self.answerStack.alpha = 0
            self.questionStack.alpha = 0
            self.isCorrectLabel.transform = CGAffineTransform(translationX: -300.0, y: 0.0)
            self.isCorrectLabel.alpha = 0
        }
        
        animation.addCompletion { [unowned self] position in
            
            // go to next question
            self.loadQuestion()
        }
        
        animation.startAnimation()
    }

    @IBAction func ans1Action(_ sender: Any) {
        disableButtons()
        checkAnswer(answer: "a")
    }
    @IBAction func ans2Action(_ sender: Any) {
        disableButtons()
        checkAnswer(answer: "b")
    }
    @IBAction func ans3Action(_ sender: Any) {
        disableButtons()
        checkAnswer(answer: "c")
    }
    
    @IBAction func nextQuestion(_ sender: UIBarButtonItem) {
        resetAnimation()
    }
}

