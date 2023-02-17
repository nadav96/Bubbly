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
    
    // MARK: collision methods
    
    private func intersections(bounds: CGRect) -> [Edge] {
        var intersections: [Edge] = []
        
        // check if center is inside
        guard bounds.contains(self.center) else {
            return intersections
        }
        
        let extraRadius: CGFloat = 1
        
        // Check if the circle extends beyond any of the rect's edges
        let minX = bounds.minX + self.radius + extraRadius
        let minY = bounds.minY + self.radius + extraRadius
        let maxX = bounds.maxX - self.radius - extraRadius
        let maxY = bounds.maxY - self.radius - extraRadius
        
        if self.center.x <= minX {
            intersections.append(.left(p: CGPoint(x: minX, y: self.center.y)))
        }
        else if self.center.x >= maxX {
            intersections.append(.right(p: CGPoint(x: maxX, y: self.center.y)))
        }
        
        if self.center.y <= minY {
            intersections.append(.top(p: CGPoint(x: self.center.x, y: minY)))
        }
        else if self.center.y >= maxY {
            intersections.append(.bottom(p: CGPoint(x: self.center.x, y: maxY)))
        }
        
        return intersections
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
        let inter = intersections(bounds: bounds)
        
        // TODO: remove block
        if inter.count > 0 {
            print(inter)
        }
        
        return inter.count > 0
    }
    
    func bounce(bounds: CGRect) {
        self.vector = -self.vector
    }
}
