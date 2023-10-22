//
//  ViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/20/23.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello World")
        setUpUI()
    }
    
    func setUpUI(){
       
        let customColor = UIColor(red: 248 / 255, green: 200 / 255 , blue: 220 / 255, alpha: 1.0)
        if let tabBar = self.tabBarController?.tabBar{
           tabBar.backgroundColor = customColor
        }
        
        
    }


}

