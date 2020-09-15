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
            TextBookView()
                .tabItem{
                    Image(systemName:"pencil")
                    Text("テキスト")
            }
            SignView()
                .tabItem{
                    Image(systemName: "car")
                    Text("標識問題")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
