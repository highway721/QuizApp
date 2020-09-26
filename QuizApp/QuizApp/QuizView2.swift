//
//  QuizView2.swift
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
struct QuizView2: View {
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
    @State private var quizAnswers: [String] = ["赤く塗られた縁石の隣","車両を販売または譲渡します","何らかの理由で交差できません","車線の左側に移動します","65mphより速くない速度","マークされていない横断歩道","ハンドルを両手で握れるように、ハンズフリーデバイスを使用してください","渋滞がなくなるまで交差点に近づかないでください","必要に応じて、減速または停止してから方向転換します","常に","ヘッドライト","他の運転手があなたが車線に戻るためのスペースを作るとは仮定しない","65 mphより速くない","事故の可能性を高めます","危険物プラカードでマークされたタンクローリー","通りの交通は左に移動します","右折を完了するには、車体を大きく振る場合があります","道路の片側が破線です","車両の側面を見て、何が来るかを確認します","危険を探すために目を動かし続けてください"]
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
       .navigationBarTitle("Quiz set2")
       }
      
       .onAppear{
           self.csvArray = self.loadCSV(fileName: "QuizSet2")
           print(self.csvArray)
           self.quizArray = self.csvArray[self.currentQuestionIndex].components(separatedBy: ",")

       }
   }
}

struct QuizView2_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

