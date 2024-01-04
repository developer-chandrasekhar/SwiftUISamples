//
//  CellSample.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 03/01/24.
//

import SwiftUI

struct CellSample: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(ColorUtil.primaryThemeColor)
                VStack(alignment: .leading) {
                    HStack {
                        timeView()
                            .frame(alignment: .topLeading)
                            .padding(.leading, -10)
                        Spacer()
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 36)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    discountInfoView()
                        .padding()
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: "face.smiling")
                                .padding(.leading)
                            Text("92% 10K+ Votes")
                                .frame(height: 36)
                                .padding(.trailing)
                                .font(.caption)
                        }
                        .background(Color.white)
                        .cornerRadius(18.0)
                        .padding(.horizontal)
                        .padding(.bottom, -18)
                        .shadow(color: .gray.opacity(0.5), radius: 4, y: 5)
                        .foregroundColor(.red)

                    }
                }
            }
            .padding()
            detailsView()
                .padding(.bottom, 8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(ColorUtil.primaryThemeColor, lineWidth: 1)
        )
        .padding()
    }
    
    private func timeView() -> some View {
        HStack {
            Image(systemName: "box.truck.badge.clock.fill")
                .foregroundColor(ColorUtil.primaryThemeColor)
                .padding(.leading, 6)
                .padding(.vertical, 6)
            Text("25-30 min")
                .font(.callout)
                .padding(.trailing, 6)
                .foregroundColor(.black.opacity(0.6))
        }
        .background(Color.white)
        .frame(width: 140)
    }
    
    private func discountInfoView() -> some View {
        VStack(alignment: .leading) {
            Text("20% OFF")
                .bold()
                .foregroundStyle(Color.white)
                .font(.title)
            Text("up to 100")
                .foregroundStyle(Color.white)
                .font(.title2)
        }
    }
    
    private func detailsView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Restaurant name")
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            
            Text("South indian, Chinese, Biryani")
                .foregroundStyle(Color.black.opacity(0.6))
                .padding(.leading)
            
            HStack {
                Text("Location  |")
                    .padding(.leading)
                    .foregroundStyle(Color.black.opacity(0.6))
                Text("4.7 km")
                    .foregroundStyle(Color.black.opacity(0.6))
                Spacer()
            }
        }
    }
}

#Preview {
    CellSample()
}
