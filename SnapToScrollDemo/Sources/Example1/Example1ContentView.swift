//
//  Example2ContentView.swift
//  Example2ContentView
//
//  Created by Trent Guillory on 9/1/21.
//

import SwiftUI
import SnapToScroll

struct Example1ContentView: View {
    var body: some View {
        
        VStack {

            Example1HeaderView()

            // Don't forget to attach snapAlignmentHelper!
            HStackSnap(alignment: .leading(16)) {

                ForEach(TagModel.exampleModels) { viewModel in

                    TagView(viewModel: viewModel)
                        .snapAlignmentHelper(id: viewModel.id)
                }
            }.padding(.top, 4)
        }
    }
}

struct Example1ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Example2ContentView()
    }
}
