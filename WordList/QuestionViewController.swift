//
//  QuestionViewController.swift
//  WordList
//
//  Created by 金崎健汰 on 2018/03/31.
//  Copyright © 2018年 LIfe is Tech. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton:UIButton!
    @IBOutlet var questionLabel:UILabel!
    @IBOutlet var answerLabel:UILabel!
    
    var isAnswered:Bool = false
    var wordArray:[Dictionary<String,String>] = []
    var shuffledwordArray:[Dictionary<String,String>] = []
    var nowNumber:Int = 0
    
    let saveData = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        wordArray = saveData.array(forKey:"WORD") as! [Dictionary<String,String>]
        
        shuffle()
        questionLabel.text = shuffledwordArray[nowNumber]["english"]
    }
    
    func shuffle(){
        while wordArray.count > 0{
            let index = Int(arc4random()) % wordArray.count
            shuffledwordArray.append(wordArray[index])
            wordArray.remove(at:index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextButtonTapped(){
        if isAnswered{
            nowNumber += 1
            answerLabel.text = ""
            
            if nowNumber < shuffledwordArray.count{
                questionLabel.text = shuffledwordArray[nowNumber]["english"]
                
                isAnswered = false
                
                nextButton.setTitle("答えを表示",for:.normal)
            }
            else{
                self.performSegue(withIdentifier:"toFinishView",sender:nil)
            }
        }
        else{
            answerLabel.text = shuffledwordArray[nowNumber]["japanese"]
            isAnswered = true
            nextButton.setTitle("次へ",for:.normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
