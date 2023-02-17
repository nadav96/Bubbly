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
        
        let circles = generateNonOverlappingCircles(numberOfCircles)
        addCircleViews(circles: circles)
        
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    private func addCircleViews(circles: [Circle]) {
        for circle in circles {
            let c = CircleView(radius: circle.radius, startVector: circle.vector, startOrigin: circle.center)
            view.addSubview(c)
            
            self.circles.append(c)
            
            
        }
    }
    
    private func generateNonOverlappingCircles(_ count: Int) -> [Circle] {
        let bounds = self.view.bounds.decreaseEqually(by: 60)
        
        let v = UIView(frame: bounds)
        self.view.addSubview(v)
        v.backgroundColor = .red
        v.alpha = 0.5
        
        print(bounds, self.view.bounds)
        
        var circles = [Circle]()
        
        while circles.count < count {
            let randomRadius = Double.random(in: 10...50)
            
            let circle = Circle(radius: randomRadius, vector: Vector.random())
            
            repeat {
                circle.moveCenterAtRandom(bounds: bounds)
            } while circle.collision(others: circles)
            
            circles.append(circle)
        }
        
        return circles
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


