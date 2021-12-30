//
//  Diamond.swift
//  Set
//
//  Created by Jhonatan Alves on 30/12/21.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let top = CGPoint(x: center.x + rect.height/2, y: rect.midY)
        let left = CGPoint(x: rect.midX, y: center.y - rect.midY)
        let bottom = CGPoint(x: center.x - rect.height/2, y: rect.midY)
        let right = CGPoint(x: rect.midX, y: center.y + rect.midY)
        
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        
        return p
    }
    
    
}
