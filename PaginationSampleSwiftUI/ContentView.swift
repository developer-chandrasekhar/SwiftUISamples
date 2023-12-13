//
//  ContentView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 13/12/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var isSearching = false
    
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
                        
            HStack {
                PageView()
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
}

#Preview {
    ContentView()
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
