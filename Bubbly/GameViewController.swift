//
//  ViewController.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class GameViewController: UIViewController {
    var circles: [CircleView] = []
    
    var displayLink: CADisplayLink?
    var lastFrameTime: CFTimeInterval = 0.0
    let targetFrameDuration = 1.0 / 60.0 // 60fps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfCircles = 10
        
        for _ in 0..<numberOfCircles {
            let randomRadius = Double.random(in: 10...50)
            let randomStartingPoint = CGPoint.random(in: self.view.bounds)
            let randomVector = Vector.random()
            
            let circle = CircleView(radius: randomRadius, startVector: randomVector, startOrigin: randomStartingPoint)
            view.addSubview(circle)
            circle.frame.origin = randomStartingPoint
            
            self.circles.append(circle)
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    @objc func gameLoop(_ displayLink: CADisplayLink) {
        let currentTime = displayLink.timestamp
        let elapsedTime = currentTime - lastFrameTime

        if elapsedTime > targetFrameDuration {
            lastFrameTime = currentTime
            updateGameState()
            render()
        }
        
    }
    
    func updateGameState() {
        
    }

    func render() {
        // Render the game graphics here
        
        for circle in circles {
            circle.render()
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
