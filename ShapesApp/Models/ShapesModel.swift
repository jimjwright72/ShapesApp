//
//  ShapesModel.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import Foundation

// MARK: - Shapes Model Enum
enum ShapesModelEnum: String {
    case circle
    case square
    case triangle
}

// MARK: - Shapes Model
struct ShapesObject: Identifiable {
    let id = UUID()
    let shapeType: ShapesModelEnum
}

// MARK: - Shapes View Model
@MainActor
class ShapesViewModel: ObservableObject {
    @Published var shapeObjects: [ShapesObject] = []
    
    // Isolate logic and manipulation of model to here to help write unit tests using new Swift Testing
    func removeAllShapes() {
        shapeObjects.removeAll()
    }
    
    func removeAllShapesMatching(_ shapeType: ShapesModelEnum) {
        shapeObjects.removeAll { $0.shapeType == shapeType }
    }
    
    func removeLastShapeMatching(_ shapeType: ShapesModelEnum) {
        if let index = shapeObjects.lastIndex(where: { $0.shapeType == shapeType }) {
            shapeObjects.remove(at: index)
        }
    }
    
    private func getShapeCountMatching(_ shapeType: ShapesModelEnum) -> Int {
        return shapeObjects.filter({ $0.shapeType == shapeType }).count
    }
    
    func getShapesCount() -> (circle: Int, square: Int, triangle: Int, total: Int) {
        return (getShapeCountMatching(.circle),getShapeCountMatching(.square),getShapeCountMatching(.triangle),shapeObjects.count)
    }
    
    func getShapeAtIndex(atIndex: Int) -> ShapesModelEnum? {
        if atIndex >= 0 && atIndex < shapeObjects.count {
            return shapeObjects[atIndex].shapeType
        }
        return nil
    }
    
    func addShape(shape: String) {
        if let shape = ShapesModelEnum(rawValue: shape) {
            shapeObjects.append(ShapesObject(shapeType: shape))
        }
    }

}
