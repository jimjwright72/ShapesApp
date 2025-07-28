//
//  TriangleView.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import SwiftUI

// Did not see Triangle as a supported shape so creating my own Shape
// using Path
struct TriangleView: Shape {
    // Following code auto added by Xcode AI
    // Code seems correct in how to draw a triangle using CGRect properties
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.midX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    TriangleView()
}
