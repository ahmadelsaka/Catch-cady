//
//  ViewController.swift
//  Catch cady
//
//  Created by Ahmad El-Saka on 11/20/17.
//  Copyright © 2017 Ahmad El-Saka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var cadyImage1: UIImageView!
    @IBOutlet weak var cadyImage2: UIImageView!
    @IBOutlet weak var cadyImage3: UIImageView!
    @IBOutlet weak var cadyImage4: UIImageView!
    @IBOutlet weak var cadyImage5: UIImageView!
    @IBOutlet weak var cadyImage6: UIImageView!
    @IBOutlet weak var cadyImage7: UIImageView!
    @IBOutlet weak var cadyImage8: UIImageView!
    @IBOutlet weak var cadyImage9: UIImageView!
    
    var score = 0
    var counter = 30
    var timer = Timer()
    var hideTimer = Timer()
    var cadyArray = [UIImageView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil {
            highscoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
        highscoreLabel.text = String(newScore)
        }
        
        
        let recongnizer1 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer2 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer3 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer4 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer5 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer6 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer7 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer8 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recongnizer9 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        cadyImage1.addGestureRecognizer(recongnizer1)
        cadyImage2.addGestureRecognizer(recongnizer2)
        cadyImage3.addGestureRecognizer(recongnizer3)
        cadyImage4.addGestureRecognizer(recongnizer4)
        cadyImage5.addGestureRecognizer(recongnizer5)
        cadyImage6.addGestureRecognizer(recongnizer6)
        cadyImage7.addGestureRecognizer(recongnizer7)
        cadyImage8.addGestureRecognizer(recongnizer8)
        cadyImage9.addGestureRecognizer(recongnizer9)
        
        cadyImage1.isUserInteractionEnabled = true
        cadyImage2.isUserInteractionEnabled = true
        cadyImage3.isUserInteractionEnabled = true
        cadyImage4.isUserInteractionEnabled = true
        cadyImage5.isUserInteractionEnabled = true
        cadyImage6.isUserInteractionEnabled = true
        cadyImage7.isUserInteractionEnabled = true
        cadyImage8.isUserInteractionEnabled = true
        cadyImage9.isUserInteractionEnabled = true
        
        
        // creating timers
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCady), userInfo: nil, repeats: true)
        
        
        // creating array
        
        cadyArray.append(cadyImage1)
        cadyArray.append(cadyImage2)
        cadyArray.append(cadyImage3)
        cadyArray.append(cadyImage4)
        cadyArray.append(cadyImage5)
        cadyArray.append(cadyImage6)
        cadyArray.append(cadyImage7)
        cadyArray.append(cadyImage8)
        cadyArray.append(cadyImage9)
        
        hideCady()
        
    }
    
    func hideCady(){
        
        for cady in cadyArray{
            cady.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(cadyArray.count)))
        
        cadyArray[randomNumber].isHidden = false
    
    }
    
    func increaseScore() {
        score = score + 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    func countDown() {
        counter = counter - 1
        timerLabel.text = "\(counter)"
        
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highscoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highscoreLabel.text = String(self.score)
                
            }
            
            let alert = UIAlertController(title: "Time Over", message: "Your time is over", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            let replay = UIAlertAction(title: "Replay", style: .default, handler: { (UIAlertAction) in
                
                self.counter = 30
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.timerLabel.text = "\(self.counter)"
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideCady), userInfo: nil, repeats: true)
                
            })
            
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
            
            UserDefaults.standard.set(score, forKey: "highscore")
        }
        
            
    }
    
    
    
    

   


}

