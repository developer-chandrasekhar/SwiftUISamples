//
//  BottomSheetView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 19/12/23.
//

import SwiftUI

private enum HomeCardType {
   
    case food
    case grocery
    
    var title: String {
        switch self {
        case .food: return "Food"
        case .grocery: return "Grocery"
        }
    }
    
    var subTitle: String {
        switch self {
        case .food: return "Great Restaurants in your towr!"
        case .grocery: return "Great shops in your towr!"
        }
    }
    
    var color: Color {
        switch self {
        case .food: return ColorUtil.primaryThemeColor
        case .grocery: return .orange
        }
    }
}

struct BottomSheetView: View {
    
    @State private var isBottomSheetShown = false
    @State var count = false
    
    var body: some View {
        VStack {

            cardView(cardType: .food)
            cardView(cardType: .grocery)
            
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
                    Text("num \(num)")
                }
            }.frame(width: UIScreen.main.bounds.width)
        }.background(
            Color.yellow
        )
    }
    
    private func cardView(cardType: HomeCardType) -> some View {
        ZStack {
            Color.white
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(cardType.color)
                Text(cardType.title)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(cardType.color)
                Text(cardType.subTitle)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.6))

                Spacer()
            }
            .padding()
            
        }
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.5), radius: 4, y: 5)
        .frame(width: 275, height: 275)
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

