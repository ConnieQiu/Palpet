//
//  GameViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/21/23.
//

import UIKit


class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var changingNumbersLabel: UILabel!
    @IBOutlet weak var userGuessedNumber: UITextField!
    var targetNumber = 0
    var userNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let lightPeachColor = UIColor(red: 255 / 255, green: 184 / 255 , blue: 201 / 255, alpha: 1.0)
        self.view.backgroundColor = lightPeachColor
        userGuessedNumber.delegate = self
        //switchNumbersLabel()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //generateGameNumber()
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func switchNumbersLabel(){
        Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true){
            timer in
            let randomNumber = Int.random(in: 1...200)
            self.changingNumbersLabel.text = String(randomNumber)
 
        }
    }
    
    func generateGameNumber(){
        targetNumber = Int.random(in: 1...200)
        print("target number:" + String(targetNumber))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNumber = Int(textField.text!) ?? 0
        print(userNumber)
        let okAction = UIAlertAction(title: "OK", style: .default){
            UIAlertAction in
            self.targetNumber = Int.random(in: 1...200)
            print("new random number:\(self.targetNumber)")
        }
        if userNumber < 1 || userNumber > 200{
           
            let alertController = UIAlertController(title: "Not in range", message: "Enter a valid number!", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            
            
        }else if userNumber == targetNumber{
            
            let alertController = UIAlertController(title: "You won!", message: "You got 100g", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            print("old player gold \(Player.shared.gold)")
            Player.shared.gold += 100
            print("new player gold \(Player.shared.gold)")
            
            
        }else if ((userNumber - 10)...(userNumber + 10)).contains(targetNumber){
            let alertController = UIAlertController(title: "So close!", message: "You got 80g", preferredStyle: .alert)
            alertController.addAction(okAction)
            print("old player gold \(Player.shared.gold)")
            Player.shared.gold += 80
            print("new player gold \(Player.shared.gold)")
            
            
        }else if ((userNumber - 20)...(userNumber + 20)).contains(targetNumber){
            let alertController = UIAlertController(title: "Somewhat close!", message: "You got 50g", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            print("old player gold \(Player.shared.gold)")
            Player.shared.gold += 50
            print("new player gold \(Player.shared.gold)")
            
            
            
        }else if ((userNumber - 50)...(userNumber + 50)).contains(targetNumber){
            
            let alertController = UIAlertController(title: "Good try!", message: "You got 30g", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            print("old player gold \(Player.shared.gold)")
            Player.shared.gold += 30
            print("new player gold \(Player.shared.gold)")
            
        }else if ((userNumber - 100)...(userNumber + 100)).contains(targetNumber){
            
            let alertController = UIAlertController(title: "Not close!", message: "You got 10g", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            print("old player gold \(Player.shared.gold)")
            Player.shared.gold += 10
            print("new player gold \(Player.shared.gold)")
            
        }else{
            print("You lose :(")
            let alertController = UIAlertController(title: "You lost :(", message: "Try again. You can do it!", preferredStyle: .alert)

            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            
        }
        textField.text = ""
        //textField.resignFirstResponder()
        return true
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
