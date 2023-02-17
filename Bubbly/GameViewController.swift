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
        
        let numberOfCircles = 10
        
        for _ in 0..<numberOfCircles {
            let randomRadius = Double.random(in: 10...50)
            let randomAngle = Double.random(in: 0...(2 * .pi))
            let randomVelocity = Double.random(in: 1...(5))
            let randomStartingPoint = CGPoint.random(in: self.view.bounds)
            
            let circle = CircleView(radius: randomRadius, color: nil)
            view.addSubview(circle)
            circle.frame.origin = randomStartingPoint
            circle.go(angle: randomAngle, velocity: randomVelocity)
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
