//
//  QuizView.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/03.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

import SwiftUI
//選択肢ABCでそれぞれ+1+2+3って加算する
//するとa=1　b=2 c=3とかになる
//解答用の配列を用意しておく(例)[1,2,3,2,1]
//マッチしたものを正解とする
//答えを表示する関数を入れる
//onTapGestureを閉める実装が必要
struct QuizView: View {
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
    @State private var quizAnswers: [String] = ["いかなる状況下で","15 mph","車輪は縁石から18インチ以内にある必要があります","高速道路の交通と同じか、それに近い速度","ロービーム","乗客または郵便のみの積載ゾーン", "赤いライトが点滅している間は停止します","現在の状況で安全な速度よりも速く運転することはできません","5","10〜15秒","100","大型トラックは、ほとんどの乗用車よりも死角が大きくなります","上記の両方","25mph","いかなる状況下で","右に曲げる（道路から離れて)","総車両重量が6000ポンド未満の場合は3軸車両","左側の縁石に最も近い車線","1,000ドルを超える物的損害が発生した場合、または怪我をした場合","乾季の後の最初の雨"]
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
       .navigationBarTitle("Quiz set1")
       }
      
       .onAppear{
           self.csvArray = self.loadCSV(fileName: "QuizSet1")
           print(self.csvArray)
           self.quizArray = self.csvArray[self.currentQuestionIndex].components(separatedBy: ",")

       }
   }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
