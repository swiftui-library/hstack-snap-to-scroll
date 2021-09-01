//
//  Example3ContentView.swift
//  Example3ContentView
//
//  Created by Trent Guillory on 9/1/21.
//

import SnapToScroll
import SwiftUI

struct Example3ContentView: View {
    
    @State private var selectedGettingStartedIndex: Int = 0
    
    var body: some View {
       
        VStack {

            Text("Getting Started")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading], 32)
            
            HStackSnap(alignment: .center(32)) {
                
                ForEach(GettingStartedModel.exampleModels) { viewModel in

                    GettingStartedView(selectedIndex: $selectedGettingStartedIndex, viewModel: viewModel)
                        .snapAlignmentHelper(id: viewModel.id)
                }
            } onSwipe: { index in
                
                selectedGettingStartedIndex = index
            }
            .frame(height: 200)
            .padding(.top, 4)
        }
        .padding([.top, .bottom], 64)
        .background(LinearGradient(colors: [Color("Cream"), Color("LightPink")], startPoint: .top, endPoint: .bottom))
    }
}

struct Example3ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Example3ContentView()
    }
}
