//
//  TabBarView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 03/01/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            GridView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            MenuContainerView {
                Text("Hello")
            }
            .tabItem {
                Label("Food", systemImage: "fork.knife.circle")
            }
            
            BottomSheetView() 
            .tabItem {
                Label("Settings", systemImage: "person.3")
            }
        }
    }
}

#Preview {
    TabBarView()
}
