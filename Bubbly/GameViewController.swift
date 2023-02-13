//
//  ViewController.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class GameViewController: UIViewController {
    var circles: [CircleView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10 {
            let circle = CircleView(radius: 50, color: nil)
            view.addSubview(circle)
            circle.frame.origin = CGPoint.random(in: self.view.bounds)
            let randomAngle = Double.random(in: 0...(2 * .pi))
            circle.go(angle: randomAngle, radius: 3)
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
}

extension CGPoint {
    static func random(in rect: CGRect) -> CGPoint {
        let x = CGFloat(Double.random(in: Double(rect.minX)...Double(rect.maxX)))
        let y = CGFloat(Double.random(in: Double(rect.minY)...Double(rect.maxY)))
        return CGPoint(x: x, y: y)
    }
}
