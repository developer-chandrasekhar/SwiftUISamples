//
//  PagingScrollView.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 20/12/23.
//

import SwiftUI
import PagingView
import SwiftUIPager


struct PVPagingScrollView<Content: View>: View {
    
    private var content: (Int) -> Content
    private var pagesCount: Int
    @State private var currentPage: Int = 0
    
    @StateObject var page: Page = .first()
    
    public init(pagesCount: Int, @ViewBuilder content: @escaping (Int) -> Content) {
        self.content = content
        self.pagesCount = pagesCount
    }
    
    var body: some View {
        VStack {
            pager()
            pageIndicator()
        }
    }
    
    private func pager() -> some View {
        Pager(page: page, data: Array(0..<pagesCount),  id: \.self) { index in
            content(index)
        }
        .alignment(.justified)
        .pagingPriority(.simultaneous)
        .itemSpacing(10)
        .padding(20)
        .onPageChanged { newIndex in
            currentPage = newIndex
        }
        .background(Color.gray.opacity(0.5))
    }
    
    private func pageIndicator() -> some View {
        HStack(spacing: 10) {
            ForEach(0..<pagesCount, id: \.self) { index in
                Circle()
                    .fill(currentPage == index ? Color.blue : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .frame(height: 8)
        .background(Color.red.opacity(0.2))

    }
}

struct PVPagingScrollView_Previews: PreviewProvider {
    static var previews: some View {
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



//struct PagingScrollView: View  {
//   
//    @State var index = 0
//    
//    //    @StateObject var page: Page = .first()
//    var items = Array(0..<5)
//    
//    
//    var body: some View {
//        
//        ZStack {
//            Pager(page: .first(), data: items,  id: \.self) { index in
//                self.pageView(index)
//            }
//            .alignment(.justified)
//            .pagingPriority(.simultaneous)
//            .itemSpacing(10)
//            .padding(20)
//            .itemAspectRatio(1.5)
//            .onPageChanged { newIndex in
//                
//            }
//        }
//        
//        
//        //        
//        //        Pager(page: $index,
//        //                      data: self.data2,
//        //                      id: \.self) {
//        //                        self.pageView($0)
//        //                }
//        //                .pagingPriority(.simultaneous)
//        //                .itemSpacing(10)
//        //                .padding(20)
//        //                .itemAspectRatio(1.3)
//        //                .background(Color.gray.opacity(0.2))
//        
//        
//        
//        
//        //        PagingView(config: .init(margin: 40, spacing: 10), page: $index) {
//        //            Group {
//        //                Color.red
//        //                Color.green
//        //                Color.blue
//        //            }
//        //            .padding(.leading, -20)
//        //            .mask(RoundedRectangle(cornerRadius: 10))
//        //            .aspectRatio(1.9, contentMode: .fit)
//        //            .onChange(of: index, perform: { value in
//        //                print(value)
//        //            })
//        //        }
//    }
//    
//    func pageView(_ page: Int) -> some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.yellow)
//                .onTapGesture {
//                    print(page)
//                }
//            Text("Page: \(page)")
//            
//        }
//        .cornerRadius(5)
//        .shadow(radius: 2)
//    }
//}

//struct PagingScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        PagingScrollView()
//    }
//}
