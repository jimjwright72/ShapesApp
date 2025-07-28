//
//  ContentView.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var shapesViewModel = ShapesViewModel()
    @State private var buttons: [CricutButton] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                // Top row of action buttons arranged in HStack
                HStack {
                    Button(action: {
                        withAnimation {
                            shapesViewModel.removeAllShapes()
                        }
                      }) {
                        Text("Clear All")
                    }
                    Spacer()
                    NavigationLink("Edit Circles") {
                        EditCirclesView().environmentObject(shapesViewModel)
                    }
                }
                
                // Grid using ScrollView and LazyVGrid to display added shapes
                GridView().environmentObject(shapesViewModel)
                
                // Bottom row of buttons returned by Rest API used to add shapes to Grid View
                if (!buttons.isEmpty) {
                    HStack {
                        ForEach(buttons, id: \.name) { button in
                            Button(action: {
                                withAnimation {
                                    shapesViewModel.addShape(shape: button.drawPath)
                                }
                            }) {
                                Text(button.name)
                            }
                            // Add a Spacer after each item excluding the last one
                            if button != buttons.last {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()
            .task {
                // Query Rest API to get buttons to add to bottom row for adding shapes to Grid View
                // I guess I could move this out of here and make a background task method
                // in view model for unit testing purposes
                buttons = await CricutRestEndpointRepositoryImpl.shared.getCricutShapeButtons()
            }
        }
    }
}

#Preview {
    ContentView()
}
