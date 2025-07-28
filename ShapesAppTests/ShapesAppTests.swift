//
//  ShapesAppTests.swift
//  ShapesAppTests
//
//  Created by Jimmy Wright on 7/28/25.
//

import Testing
@testable import ShapesApp

struct ShapesAppTests {

    @MainActor @Test func addCircle() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        let shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 1 && shapes.total == 1 && shapes.circle == 1 && shapes.square == 0 && shapes.triangle == 0)
    }
    
    @MainActor @Test func addSquare() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.square.rawValue)
        let shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 1 && shapes.total == 1 && shapes.circle == 0 && shapes.square == 1 && shapes.triangle == 0)
    }
    
    @MainActor @Test func addTriangle() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.triangle.rawValue)
        let shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 1 && shapes.total == 1 && shapes.circle == 0 && shapes.square == 0 && shapes.triangle == 1)
    }
    
    @MainActor @Test func addAllShapes() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        svm.addShape(shape: ShapesModelEnum.square.rawValue)
        svm.addShape(shape: ShapesModelEnum.triangle.rawValue)
        let shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 3 && shapes.total == 3 && shapes.circle == 1 && shapes.square == 1 && shapes.triangle == 1)
    }
    
    @MainActor @Test func removeAllShapes() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        svm.addShape(shape: ShapesModelEnum.square.rawValue)
        svm.addShape(shape: ShapesModelEnum.triangle.rawValue)
        var shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 3 && shapes.total == 3 && shapes.circle == 1 && shapes.square == 1 && shapes.triangle == 1)
        svm.removeAllShapes()
        shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 0 && shapes.total == 0 && shapes.circle == 0 && shapes.square == 0 && shapes.triangle == 0)
    }
    
    @MainActor @Test func removeAllShapesMatchingCircle() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.triangle.rawValue)
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        svm.addShape(shape: ShapesModelEnum.square.rawValue)
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        var shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 4 && shapes.total == 4 && shapes.circle == 2 && shapes.square == 1 && shapes.triangle == 1)
        svm.removeAllShapesMatching(ShapesModelEnum.circle)
        shapes = svm.getShapesCount()
        #expect(svm.shapeObjects.count == 2 && shapes.total == 2 && shapes.circle == 0 && shapes.square == 1 && shapes.triangle == 1)
    }
    
    @MainActor @Test func removeLastCircle() {
        let svm = ShapesViewModel()
        svm.addShape(shape: ShapesModelEnum.triangle.rawValue)
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        svm.addShape(shape: ShapesModelEnum.circle.rawValue)
        svm.addShape(shape: ShapesModelEnum.square.rawValue)
        var shape = svm.getShapeAtIndex(atIndex: 1)
        #expect(shape == ShapesModelEnum.circle)
        svm.removeLastShapeMatching(ShapesModelEnum.circle)
        shape = svm.getShapeAtIndex(atIndex: 1)
        #expect(shape == ShapesModelEnum.circle)
        svm.removeLastShapeMatching(ShapesModelEnum.circle)
        shape = svm.getShapeAtIndex(atIndex: 1)
        #expect(shape == ShapesModelEnum.square)
    }
    
    @Test func getButtons() async {
        let buttons = await CricutRestEndpointRepositoryImpl.shared.getCricutShapeButtons()
        let buttonNames = Set(buttons.map { $0.name })
        #expect(buttonNames.count == 3)
        let requiredNames: Set<String> = ["Circle", "Square", "Triangle"]
        #expect(requiredNames.isSubset(of: buttonNames))
    }

}
