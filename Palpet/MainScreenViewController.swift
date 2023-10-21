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
       
        let customColor = UIColor(red: 218.0 / 255.0, green: 191.0 / 255.0 , blue: 215.0 / 255.0 , alpha: 1.0)
        if let tabBar = self.tabBarController?.tabBar{
           tabBar.backgroundColor = customColor
        }
        
        
    }


}

