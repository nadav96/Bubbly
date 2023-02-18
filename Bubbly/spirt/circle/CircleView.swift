//
//  CircleView.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 13/02/2023.
//

import UIKit

class CircleView: UIView {
    let COLORS: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.purple]
    
    var circle: Circle = .zero
    
    var colorIndex: Int = 0
    var color: UIColor = .red
    
    var v: UIView!
    
    let arrowLayer = CAShapeLayer()
    
    var isArrowEnabled = true
    
    // MARK: -
    convenience init(circle: Circle, color: UIColor? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.circle = circle
        
        // add color
        self.colorIndex = Int(arc4random_uniform(UInt32(self.COLORS.count)))
        self.color = color != nil ? color! : COLORS[self.colorIndex]
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = false
        
        // MARK: initial location
        self.frame.size = CGSize(width: self.circle.radius * 2, height: self.circle.radius * 2)
        self.center = self.circle.center
        
        self.setupCircle()
        
        self.v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        v.backgroundColor = .black
        self.v.layer.cornerRadius = 5
        self.addSubview(v)
        self.v.isHidden = true
        
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {        
        self.colorIndex = (self.colorIndex + 1) % self.COLORS.count
        self.color = self.COLORS[self.colorIndex]
        
        self.setupCircle()
    }
    var step = 0
    override func layoutSubviews() {
        self.v.frame.origin = CGPoint(x: self.frame.width/2 - 5, y: self.frame.height/2 - 5)
        if self.isArrowEnabled {
            self.drawArrow(from: self.v.frame.origin + CGPoint(x: 5, y: 5), angle: self.circle.vector.angle, velocity: self.circle.vector.length)
        }
    }
    
    private func polar(alpha: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        let x = cos(alpha) * radius
        let y = -sin(alpha) * radius
        return CGPoint(x: x, y: y) + offset
    }
    
    private func setupCircle() {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = self.color.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        
        layer.addSublayer(shapeLayer)
    }
    
    func render() {        
        self.circle.move()

        self.center = self.circle.center
    }
    
    func removeArrow() {
        self.arrowLayer.removeFromSuperlayer()
        self.isArrowEnabled = false
    }
    
    func isSameColor(other: CircleView) -> Bool {
        return self.colorIndex == other.colorIndex
    }

    private func drawArrow(from: CGPoint, angle: CGFloat, velocity: CGFloat) {
        let endPoint = endPoint(from: from, angle: angle, length: self.circle.radius + velocity)
        
        drawLine(from: from, to: endPoint, color: .black, width: 2)
    }

    private func endPoint(from startPoint: CGPoint, angle: CGFloat, length: CGFloat) -> CGPoint {
        let dx = length * cos(angle)
        let dy = -length * sin(angle)
        return CGPoint(x: startPoint.x + dx, y: startPoint.y + dy)
    }
    
    private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint, color: UIColor, width: CGFloat) {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        self.arrowLayer.path = path.cgPath
        self.arrowLayer.strokeColor = color.cgColor
        self.arrowLayer.lineWidth = width

        // Add the shape layer to your view's layer
        self.layer.addSublayer(self.arrowLayer)
    }


}
