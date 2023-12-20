//
//  ContentView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 13/12/23.
//

import SwiftUI
import UIKit

struct User: Identifiable{
    var id = UUID().uuidString
    var userName: String
    var userImage: String
}

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var isSearching = false
    
    @State var currentIndex: Int = 0
    @State var users: [User] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView()
            HStack {
                Image(systemName: "location.square.fill")
                    .resizable()
                    .padding(.leading)
                    .frame(width: 44, height: 34)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Location")
                    Text("India")
                }
                SearchBar(searchText: $searchText, isSearching: $isSearching)
                    .padding(.horizontal, 0)
            }.padding(.horizontal, 0)
            
            VStack {
                pView().padding(.horizontal)
            }

            Text("Recommended Restaurants")
                .padding(.leading)
            GridView()
            Spacer()
        }
    }
    
    func headerView() -> some View {
        return HStack {
            
            roundRectButton(title: "Food", size: CGSize(width: 200, height: 36)) {
                
            }
            
            roundRectButton(title: "Grocery", size: CGSize(width: 200, height: 36)) {
                
            }
            
        }.padding()
    }
    
    func pView() -> some View {
        PVPagingScrollView(pagesCount: 5) { index in
            ZStack {
                Rectangle()
                    .fill(Color.yellow)
                    .onTapGesture {
                        print(index)
                    }
                Text("Page: \(index)")
            }
            .cornerRadius(5)
            .shadow(radius: 2)
        }
    }
}

#Preview {
    ContentView()
}

struct Carousel<Content: View, T: Identifiable>: View {
    
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    
    @Binding var index: Int
    
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 80, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.content = content
        
        self._index = index
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            VStack {
                
                HStack(spacing: spacing) {
                    ForEach(list){item in
                        content(item)
                            .frame(width:  itemWidth(screenWidth: proxy.size.width), height: 100)
                    }
                }
                .padding(.horizontal,spacing)
                .offset(x: (CGFloat(currentIndex) * -width) + ((currentIndex != 0 || currentIndex == list.count - 1) ? adjustmentWidth : 0) + offset)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            currentIndex = index
                        })
                        .onChanged({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                )
            }
        }
        .animation(.easeInOut, value: offset == 0)
        
        // Indicator dots
        HStack(spacing: 10) {
            
            ForEach(list.indices, id: \.self){index in
                
                Circle()
                    .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                    .frame(width: 10, height: 10)
                    .scaleEffect(currentIndex == index ? 1.4 : 1)
                    .animation(.spring(), value: currentIndex == index)
            }
        }
        .padding(.bottom,40)
    }
    
    func itemWidth(screenWidth: CGFloat) -> CGFloat {
        if currentIndex == 0 || currentIndex == list.count - 1 {
            return screenWidth - trailingSpace/2 - spacing
        }
        return screenWidth - trailingSpace
    }
}
















struct PageView: View {
    var body: some View {
        TabView {
            ForEach(0..<5) { i in
                ZStack {
                    Color.gray
                    Text("Image \(i+1)").foregroundColor(.white)
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding(.all, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
}


public func roundRectButton(title: String, isDisabled: Bool = false, size: CGSize = CGSize(width: 0, height: 56), click: @escaping () -> Void) -> some View {
    Button {
        click()
    } label: {
        Text(title)
            .padding()
            .frame(maxWidth: size.width == 0 ? .infinity : size.width)
            .frame(height: size.height)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(
                    cornerRadius: size.height/7,
                    style: .continuous
                )
                .fill(isDisabled ? ColorUtil.theme_color_gradient_start.opacity(0.5) : ColorUtil.primaryThemeColor)
            )
    }
}


struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, 24)
            
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing)
            .opacity(searchText.isEmpty ? 0 : 1)

        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
    }
}


struct PageViewWithScroll: View {
    let items = Array(1...10) // Replace this with your data
    @State private var currentPage = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(items.indices, id: \.self) { index in
                            GeometryReader { itemGeometry in
                                let offset = itemGeometry.frame(in: .global).minX
                                let width = geometry.size.width
                                let currentItem = CGFloat(index)
                                
                                Text("\(items[index])")
                                    .frame(width: width * 0.8, height: 200)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .opacity(opacity(for: offset, width: width))
                                    .onTapGesture {
                                        withAnimation {
                                            currentPage = index
                                        }
                                    }
                                    .rotation3DEffect(
                                        .degrees(Double((offset - width) / width * -30)),
                                        axis: (x: 0.0, y: 1.0, z: 0.0),
                                        anchor: .center,
                                        perspective: 0.5
                                    )
                                    .offset(x: offset - width * currentItem)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 200)
                
                HStack(spacing: 10) {
                    ForEach(0..<items.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.blue : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 10)
                
                
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
    
    func opacity(for offset: CGFloat, width: CGFloat) -> Double {
        let centerX = width / 2
        let delta = abs(offset - centerX)
        let fullAlphaWidth = width * 0.8 / 2
        let alpha = 1 - delta / fullAlphaWidth
        
        return max(0, min(1, Double(alpha)))
    }
}

