//
//  ViewController.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class GameViewController: UIViewController {
    private var startTime: Date?
    private var timer: Timer?
    
    let MAX_CIRCLE_CREATION_ATTEMPTS = 30
    
    let numberOfCircles = 4
    
    var circles: [CircleView] = []
    var bounds: CGRect = .zero
    var boundsView: UIView!
    
    var displayLink: CADisplayLink?
    var lastFrameTime: CFTimeInterval = 0.0
    let targetFrameDuration = 1.0 / 60.0 // 60fps
    
    var isGameRunning = true
    
    @IBOutlet weak var gameContainerView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var frames: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBounds()
        
        let circles = generateNonOverlappingCircles(bounds: self.bounds, count: numberOfCircles)
        addCircleViews(circles: circles)
        
        self.start()
    }
    
    func start() {
        startTime = Date()
        
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    func stop() {
        timer?.invalidate()
        self.displayLink?.invalidate()
    }
    
    func updateTime() {
        guard let startTime = self.startTime else {
            return
        }
        let elapsedTime = Date().timeIntervalSince(startTime)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second, .nanosecond]
        formatter.unitsStyle = .positional
        if let formattedString = formatter.string(from: elapsedTime) {
            self.durationLabel.text = formattedString
        }
    }
    
    private func setBounds() {
        // TODO: need to fix bounds so it will be controllable (if we want to resize the bounds mid fly)
        self.bounds = self.gameContainerView.frame
        self.boundsView = UIView(frame: self.gameContainerView.bounds)
        self.gameContainerView.addSubview(self.boundsView)
//        self.boundsView.backgroundColor = .red
//        self.boundsView.alpha = 0.5
        
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
        if !isGameRunning {
            self.stop()
            return
        }
        
        updateTime()

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
            
            let others = self.circles.compactMap({ (circle == $0) || (circle.colorIndex != $0.colorIndex) ? nil : $0.circle })
            if circle.circle.collision(others: others, spacing: 0) {
                self.isGameRunning = false
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


