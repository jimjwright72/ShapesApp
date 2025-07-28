//
//  EditCirclesView.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import SwiftUI

struct EditCirclesView: View {
    @EnvironmentObject var shapesViewModel: ShapesViewModel
    
    var body: some View {
        VStack {
            GridView(showOnlyCircles: true).environmentObject(shapesViewModel)
            HStack {
                Button(action: {
                    withAnimation {
                        shapesViewModel.removeAllShapesMatching(.circle)
                    }
                }) {
                    Text("Delete All")
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        shapesViewModel.addShape(shape: ShapesModelEnum.circle.rawValue)
                    }
                }) {
                    Text("Add")
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        shapesViewModel.removeLastShapeMatching(.circle)
                    }
                }) {
                    Text("Remove")
                }
            }
        }
        .padding()
    }
}

#Preview {
    let svm = ShapesViewModel()
    svm.addShape(shape: "circle")
    svm.addShape(shape: "circle")
    svm.addShape(shape: "circle")
    return EditCirclesView().environmentObject(svm)
}
