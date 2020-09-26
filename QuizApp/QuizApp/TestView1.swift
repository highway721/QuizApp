//
//  TestView1.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/19.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//
//選択肢ABCでそれぞれ+1+2+3って加算する
//するとa=1　b=2 c=3とかになる
//解答用の配列を用意しておく(例)[1,2,3,2,1]
//マッチしたものを正解とする
//答えを表示する関数を入れる
//onTapGestureを閉める実装が必要
import SwiftUI

struct TestView1: View {
    //現在の問題番号
    @State private var currentQuestionIndex = 0
    //これは固定
    let minQuestionNumber = -1
    //答え表示用
    @State private var showAnswer = false
    //答え表示用配列
    @State private var quizAnswers: [String] = []
    //問題格納配列
    @State private var quizArray: [String] = []
    var body: some View {
           NavigationView{
           Text("Test View!")
            Spacer()
            HStack{
                Text("a")
                Text("b")
            }
           }
       }
   }

struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
