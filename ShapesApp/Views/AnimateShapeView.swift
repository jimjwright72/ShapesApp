//
//  AnimateShapeView.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import SwiftUI

// Not really necessary but try to spice it up a bit by animating opacity/scale when adding shape to grid
// Unfortunately LazyVGrid was causing some issues where animation did not work sometimes using .transition(.scale).
// I believe due to nature of LazyVGrid re-cycling or re-using previous shapes the transition modifier did not fire
// It only seems to work correctly by animating from .onAppear
struct AnimateShapeView: View {
    let shape: ShapesObject
    let size: CGFloat
    let onlyCircles: Bool
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0

    var body: some View {
        Group {
            switch shape.shapeType {
            case .circle:
                Circle().fill(.teal)
                    .accessibilityIdentifier("circleView")
            case .square:
                if !onlyCircles { Rectangle().fill(.teal).accessibilityIdentifier("squareView") }
            case .triangle:
                if !onlyCircles { TriangleView().fill(.teal).accessibilityIdentifier("triangleView") }
            }
        }
        .frame(width: size, height: size)
        // Previously I was only doing .transition(.scale) instead of all of the following.
        // But animation did not work if you added shapes, removed all the shapes, and then starting adding shapes to grid again.  The first few shapes when added back would not animate.
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    AnimateShapeView(shape: ShapesObject(shapeType: ShapesModelEnum.triangle), size: 100, onlyCircles: false)
}
