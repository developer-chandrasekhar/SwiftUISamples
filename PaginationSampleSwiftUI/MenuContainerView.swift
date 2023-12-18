//
//  MenuContainar.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 18/12/23.
//

import SwiftUI


struct MenuListItem: Identifiable, Codable {
    let id: String
    let imageName: String
    let title: String
}

struct ListItemView: View {
    
    let menuListItem: MenuListItem
    
    var body: some View {
        VStack {
            Image(menuListItem.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44)
            Text(menuListItem.title)
        }
    }
}

struct MenuContainerView<Content: View>: View {
    
    @ViewBuilder var contentView: Content
    @State var isMenuSelected = false
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.contentView = content()
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                ZStack {
                    if isMenuSelected {
                        Color.black.opacity(0.01)
                            .onTapGesture {
                                isMenuSelected = false
                            }
                            .animation(.easeInOut, value: isMenuSelected)
                    }
                    
                    HStack {
                        MenuView(isOpen: $isMenuSelected)
                            .animation(.easeInOut, value: isMenuSelected)
                            .padding(.top, geometry.safeAreaInsets.top)
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                
                menuButton()
                    .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .bottom)
                    .padding(24)
                
            }
        }
    }
    
    private func menuButton() -> some View {
        
        ZStack {
            ColorUtil.primaryThemeColor
                .clipShape(Circle())
                .shadow(radius: 10)
            Image(systemName: isMenuSelected ? "arrow.down.right.and.arrow.up.left" : "menucard")
                .scaledToFit()
                .imageScale(.large)
                .foregroundStyle(.white)
        }
        .frame(width: 64, height: 64)
        .onTapGesture {
            isMenuSelected.toggle()
        }
    }
}


struct BodyView: View {
    
    var body: some View {
        
        MenuContainerView {
            List {
                VStack {
                    Text("Helloo...")
                }
            }
        }
    }
}

#Preview {
    BodyView()
}


struct MenuView: View {
    
    @Binding var isOpen: Bool
    let menuWidth = UIScreen.main.bounds.width * 0.3
    
    let menuListItems: [MenuListItem] = [
        MenuListItem(id: "Item1" , imageName: "placeholder", title: "Item1"),
        MenuListItem(id: "Item2" , imageName: "placeholder", title: "Item2"),
        MenuListItem(id: "Item3" , imageName: "placeholder", title: "Item3"),
        MenuListItem(id: "Item4" , imageName: "placeholder", title: "Item4"),
        MenuListItem(id: "Item5" , imageName: "placeholder", title: "Item5"),
        MenuListItem(id: "Item6" , imageName: "placeholder", title: "Item6"),
        MenuListItem(id: "Item7" , imageName: "placeholder", title: "Item7"),
        MenuListItem(id: "Item8" , imageName: "placeholder", title: "Item8"),
        MenuListItem(id: "Item9" , imageName: "placeholder", title: "Item9")
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                List {
                    ForEach(0..<menuListItems.count, id: \.self) { index in
                        ListItemView(menuListItem: menuListItems[index])
                    }
                    .frame(width: menuWidth)
                }
                .listStyle(PlainListStyle())
                .padding(.top, geometry.safeAreaInsets.top)
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                Spacer()
                
            }
            .frame(width: isOpen ? menuWidth: 0)
            .background()
        }
    }
}
