//
//  ViewController.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class GameViewController: UIViewController {
    var circle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.circle = CircleView()
//        self.circle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        self.view.addSubview(self.circle)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.circle?.frame.origin = self.view.center
    }
}

