//
//  Circle.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 17/02/2023.
//

import Foundation

class Circle {
    public var center: CGPoint
    public let radius: CGFloat
    public var vector: Vector
    
    public static let zero = Circle(radius: 0, vector: .zero)
    
    /// Creates a circle object with a given radius and center, and if center is null, set it as zero
    init(radius: CGFloat, vector: Vector, center: CGPoint? = nil) {
        self.center = center ?? .zero
        self.radius = radius
        self.vector = vector
    }
    
    func moveCenterAtRandom(bounds: CGRect) {
        self.center = CGPoint.random(in: bounds, radius: 2 * self.radius)
    }
    
    func move() {
        let distancePerFrame = self.vector.length / 60
        
        let dx = distancePerFrame * cos(self.vector.angle)
        let dy = -distancePerFrame * sin(self.vector.angle)
        
        center.x += dx
        center.y += dy
    }
    
    func collision(others: [Circle], spacing: CGFloat = 20) -> Bool {
        var overlaps = false
        
        for other in others {
            let distance = sqrt(pow(self.center.x - other.center.x, 2) + pow(self.center.y - other.center.y, 2))
            
            if distance < radius + other.radius + spacing {
                overlaps = true
                break
            }
        }

        return overlaps
    }
    
    func collision(bounds: CGRect) -> Bool {
        return !bounds.contains(self.center)
    }
}
