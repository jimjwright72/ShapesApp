//
//  GridView.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import SwiftUI

// GridView is used by both ShapesGridView and EditCirclesView
// EditCircleView sets onlyCircles to true to not show squares or rectangles
//
// Tried to make grid layout adaptive to device, assignment did not really provide guidance on this
//
// Scrolling is not really addressed on whether you should scroll to bottom after adding/removing shape.
//

struct GridView: View {
    @EnvironmentObject var shapesViewModel: ShapesViewModel
    
    var onlyCircles: Bool = false
    init(showOnlyCircles: Bool = false) {
        onlyCircles = showOnlyCircles
    }
    
    // Define row/column layout with padding
    private let size: CGFloat = 100
    private let rowPadding: CGFloat = 16
    private let columnPadding: CGFloat = 16
    private var columns: [GridItem] {
        return [
            .init(.adaptive(minimum: size, maximum: size), spacing: columnPadding)
        ]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: rowPadding) {
                ForEach(shapesViewModel.shapeObjects, id: \.id) { shape in
                    AnimateShapeView(shape: shape, size: size, onlyCircles: onlyCircles)
                }
            }
        }
    }
}

#Preview {
    let svm = ShapesViewModel()
    svm.addShape(shape: "circle")
    svm.addShape(shape: "square")
    svm.addShape(shape: "triangle")
    return GridView().environmentObject(svm)
}
