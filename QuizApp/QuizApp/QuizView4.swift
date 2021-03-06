//
//  QuizView4.swift
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
struct QuizView4: View {
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
    @State private var quizAnswers: [String] = ["横断歩道の標示があってもなくても","曲がる前に自転車道に入っていく","法律に依って禁止されています","荷物か乗客を乗り下りしたりしている","前方に何らかの危険か衝突事故あるかも知れない","前方にある道路の状態が変わっている","時速25マイル","他の車を先に行かせるため","はい、接近する車があれば、それを知ることが出来る","アクセルからあなたの足を離す","運転者が交通の流れよりも早く走るか遅く走る","0.08%","決して許されません","18才以上の年齢の者がその子と一緒に乗っている","常に先行権を与えなければならない","停車し、安全ならば前進する","オートバイの後ろを運転する車は距離を十分にあけなければならない","時速15マイル","大型トラックは完全に止まるまで時間がかかる","ブレーキを踏まずだんだん速度を落とす"]
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
       .navigationBarTitle("Quiz set4")
       }
      
       .onAppear{
           self.csvArray = self.loadCSV(fileName: "QuizSet4")
           print(self.csvArray)
           self.quizArray = self.csvArray[self.currentQuestionIndex].components(separatedBy: ",")

       }
   }
}

struct QuizView4_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

