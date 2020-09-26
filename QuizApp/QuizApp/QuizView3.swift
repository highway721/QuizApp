//
//  QuizView3.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/15.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

import SwiftUI
//選択肢ABCでそれぞれ+1+2+3って加算する
//するとa=1　b=2 c=3とかになる
//解答用の配列を用意しておく(例)[1,2,3,2,1]
//マッチしたものを正解とする
//答えを表示する関数を入れる
//onTapGestureを閉める実装が必要
struct QuizView3: View {
    //現在の問題番号
    @State private var currentQuestionIndex = 0
    //クイズの数の値−１を入れる(CSVファイル用)
    let maxQuestionNumberForCsv = 19
    //これは固定
    let minQuestionNumber = -1
    //CSVファイル格納配列
    @State private var csvArray: [String] = []
    //CSVファイルの問題格納配列
    @State private var quizArray: [String] = []
    //答え表示用
    @State private var showAnswer = false
    //答え表示用配列
    @State private var quizAnswers: [String] = ["乗用車が前方にいる場合よりも後ろの距離を保つ","両耳を覆うヘッドフォンで音楽を聴く","反対側の道路に踏切を横断するための十分な余地がない場合","他のドライバーをイライラさせて怒らせることができます","いいえ、運転が遅すぎると交通混乱させます","常に","右折しようとする交差点から200フィート以内にいるとき","ゆっくりと交差点を注意深く横断します","停止して、彼/彼女が通りを渡るのを待ってください","破線の隣が通れます","頭を回して後ろを見る"," 運転をする前に頭を冷やす","誰の責任であっても"," 前照灯を下向きに切り替える","5日以内","道路を車両と共有する権利があるから","反対方向の交通を区分する","時速15マイル","カリフォルニアで運転している時はいつでも","近づいてくる車が無くなるまで"]
    //次の問題を表示させるための関数(CSVファイル用)
       func nextQuiz(){
        self.currentQuestionIndex = self.currentQuestionIndex + 1
        if self.currentQuestionIndex == self.maxQuestionNumberForCsv + 1 || self.currentQuestionIndex == self.minQuestionNumber{
            self.currentQuestionIndex = maxQuestionNumberForCsv
        }
           quizArray.removeAll()
              quizArray = csvArray[currentQuestionIndex].components(separatedBy: ",")
       }
   //前の問題を表示させるための関数(CSVファイル用)
   func lastQuiz(){
    self.currentQuestionIndex = self.currentQuestionIndex - 1
    if self.currentQuestionIndex == self.maxQuestionNumberForCsv || self.currentQuestionIndex == self.minQuestionNumber{
    self.currentQuestionIndex = 0
    }
       quizArray.removeAll()
          quizArray = csvArray[currentQuestionIndex].components(separatedBy: ",")
   }
   //CSVファイルを読み込むための関数
   func loadCSV(fileName: String) -> [String] {
       let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
       do {
           let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
           let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
           csvArray = lineChange.components(separatedBy: "\n")
       } catch {
           print("エラー")
       }
       return csvArray
   }
    var body: some View {
NavigationView{
       VStack{
       //問題数の表示
       Text("Current Question is \(currentQuestionIndex + 1)/20")
        .font(.title)
       Spacer()
           Text(String(describing: quizArray))
       Spacer()
           Text("答えはここをタップ")
            .onTapGesture {
                self.showAnswer.toggle()
        }
        if showAnswer{
            Text(quizAnswers[currentQuestionIndex])
            .foregroundColor(.blue)
            .fontWeight(.medium)
        }
       Spacer()
           HStack{
               Button("Last Question"){
                   self.lastQuiz()
                   self.showAnswer = false
                   }
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.orange)
                   .font(.body)
                   .cornerRadius(40)
               Spacer()
               Button("Next Question"){
                   
                   self.nextQuiz()
                   self.showAnswer = false
                   }
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.blue)
                   .font(.body)
                   .cornerRadius(40)
               }
           }
       .navigationBarTitle("Quiz set3")
       }
      
       .onAppear{
           self.csvArray = self.loadCSV(fileName: "QuizSet3")
           print(self.csvArray)
           self.quizArray = self.csvArray[self.currentQuestionIndex].components(separatedBy: ",")

       }
   }
}

struct QuizView3_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
