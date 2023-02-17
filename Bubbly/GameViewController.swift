//
//  ViewController.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class GameViewController: UIViewController {
    let MAX_CIRCLE_CREATION_ATTEMPTS = 30
    
    let numberOfCircles = 10
    
    var circles: [CircleView] = []
    var bounds: CGRect = .zero
    var boundsView: UIView!
    
    var displayLink: CADisplayLink?
    var lastFrameTime: CFTimeInterval = 0.0
    let targetFrameDuration = 1.0 / 60.0 // 60fps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBounds()
        
        let circles = generateNonOverlappingCircles(bounds: self.bounds, count: numberOfCircles)
        addCircleViews(circles: circles)
        
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    private func setBounds() {
        self.bounds = self.view.bounds.decreaseEqually(by: 60)
        self.boundsView = UIView(frame: self.bounds)
        self.view.addSubview(self.boundsView)
        self.boundsView.backgroundColor = .red
        self.boundsView.alpha = 0.5
        
    }
    
    private func addCircleViews(circles: [Circle]) {
        for circle in circles {
            let c = CircleView(circle: circle)
            view.addSubview(c)
            
            self.circles.append(c)
            
            
        }
    }
    
    private func generateNonOverlappingCircles(bounds: CGRect, count: Int) -> [Circle] {
        var circles = [Circle]()
        
        while circles.count < count {
            // TODO: ? Double.random(in: 10...50) -> CGFloat(arc4random_uniform(10)*3+50)
            let randomRadius = Double.random(in: 10...50)
            
            let circle = Circle(radius: randomRadius, vector: Vector.random())
            
            var i = 0
            repeat {
                i += 1
                circle.moveCenterAtRandom(bounds: bounds)
            } while circle.collision(others: circles) && i < MAX_CIRCLE_CREATION_ATTEMPTS
            
            if i >= MAX_CIRCLE_CREATION_ATTEMPTS {
                // try next attmpet, with different radius
                print("ERR: circle creation")
            }
            else {
                circles.append(circle)
            }
            
            
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
        for circle in circles {
            if circle.circle.collision(bounds: self.bounds) {
                circle.circle.bounce(bounds: self.bounds)
            }
        }
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


