//
//  BottomSheetView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 19/12/23.
//

import SwiftUI

struct BottomSheetView: View {
    
    @State private var isBottomSheetShown = false
    @State var count = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                isBottomSheetShown.toggle()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            
            Button("122") {
                count.toggle()
            }.background(
                Color.red
            )
        }
        .overlay {
            BottomSheet(isOpen: $isBottomSheetShown) {
                bottomSheetContentView()
            }
            
            BottomSheet(isOpen: $count) {
                bottomSheetContentView1()
            }
        }
    }
    
    private func bottomSheetContentView() -> some View {
        ScrollView {
            VStack {
                ForEach(0..<10) { num in
                    Text("num")
                }
            }.frame(width: UIScreen.main.bounds.width)
        }.background(
            Color.red
        )
    }
    
    private func bottomSheetContentView1() -> some View {
        ScrollView {
            VStack {
                ForEach(10..<20) { num in
                    Text("num ")
                }
            }.frame(width: UIScreen.main.bounds.width)
        }.background(
            Color.yellow
        )
    }
}

#Preview {
    BottomSheetView()
}

struct BottomSheet<Content: View>: View {
    
    @Binding var isOpen: Bool
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack {
            Color(UIColor.black.withAlphaComponent(isOpen ? 0.1 : 0))
                .frame(width: UIScreen.main.bounds.width, height: isOpen ? UIScreen.main.bounds.height : 0)
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
                .onTapGesture {
                    isOpen.toggle()
                }
            VStack {
                Spacer()
                content
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                    .offset(y: isOpen ? 0 : UIScreen.main.bounds.height)
                    .animation(.spring(), value: isOpen)
            }
        }
    }
}
