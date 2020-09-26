//
//  ContentView.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/03.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("ホーム")
            }
            SignView()
                .tabItem{
                    Image(systemName: "car")
                    Text("標識問題")
            }
//            TestView1()
//                .tabItem{
//                    Image(systemName: "hare")
//                    Text("その他")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
