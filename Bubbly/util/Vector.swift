//
//  Vector.swift
//  Bubbly
//
//  Created by Nadav Goldstein on 17/02/2023.
//

import Foundation

class Vector {
    public let angle: CGFloat
    public let length: CGFloat
    
    static let zero = Vector(angle: 0, length: 0)
    
    init(angle: CGFloat, length: CGFloat) {
        self.angle = angle
        self.length = length
    }
    
    static func random() -> Vector {
        let randomAngle = CGFloat.random(in: 0...(2 * .pi))
        // TODO: 80.0 -> CGFloat.random(in: 10...(100))
        let randomLength = 200.0
        return Vector(angle: randomAngle, length: randomLength)
    }

    func reverse() -> Vector {
        return Vector(angle: angle + .pi, length: length)
    }
    
    static prefix func - (vector: Vector) -> Vector {
        return Vector(angle: vector.angle + .pi, length: vector.length)
    }
}
