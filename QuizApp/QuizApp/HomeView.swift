//
//  HomeView.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/03.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

//セット選択のボタンを押しやすくする

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: QuizView()){
                    Text("クイズセット(1)")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.body)
                }
                Spacer()
                 .frame(height: 40)
                NavigationLink(destination: QuizView2()){
                    Text("クイズセット(2)")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.body)
                }
                Spacer()
                 .frame(height: 40)
                NavigationLink(destination: QuizView3()){
                    Text("クイズセット(3)")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.body)
                }
                Spacer()
                .frame(height: 40)
                NavigationLink(destination: QuizView4()){
                                   Text("クイズセット(4)")
                                   .padding()
                                   .foregroundColor(.white)
                                   .background(Color.blue)
                                   .font(.body)
                               }
            .navigationBarTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
