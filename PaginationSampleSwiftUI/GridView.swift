//
//  GridView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 13/12/23.
//

import SwiftUI

struct GridView: View {
    let items = (1...20).map { $0 } // Example items
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Image(systemName: "photo" )
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .foregroundColor(.gray.opacity(0.2))
                             
                        Text("Restarent name")
                            .foregroundStyle(.secondary)
                        HStack {
                            RatingView().padding(.leading, 8)
                            Text("140 Rating")
                                .font(.footnote)
                        }
                        Text("Location")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.all, 8)
    
                }
            }
            .padding(.all, 0)
        }
        .navigationTitle("Grid List View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}

struct StarView: View {
    let filled: Bool

    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .resizable()
            .frame(width: 10, height: 10)
            .foregroundColor(filled ? .yellow : .gray)
            .imageScale(.medium)
            .padding(.all, 0)
    }
}

struct RatingView: View {
    var body: some View {
        HStack {
            StarView(filled: true)
            StarView(filled: true)
            StarView(filled: true)
            StarView(filled: true)
            StarView(filled: false)
        }
        .font(.title)
    }
}
