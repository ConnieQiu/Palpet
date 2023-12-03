//
//  TabBarViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/28/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //set relationship between WeatherViewController to MainScreenViewController
        if let viewControllers = viewControllers{
            for viewController in viewControllers{
                if let mainScreenViewController = viewController as? MainScreenViewController{
                    if let weatherViewController = viewControllers[3] as? WeatherViewController{
                        weatherViewController.delegate = mainScreenViewController
                    }
                }
            }
        }
        
        
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
