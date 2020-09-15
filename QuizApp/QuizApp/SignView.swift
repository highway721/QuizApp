//
//  SignView.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/03.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

import SwiftUI

struct SignView: View {
    //現在の問題番号
    @State private var currentQuestionIndex = 0
    //標識の画像の数の値を入れる(CSVファイル用)
    let maxQuestionNumberForCsv = 25
    //標識の画像の数の値を入れる
    let maxQuestionNumber = 25
    //これは固定
    let minQuestionNumber = -1
    //標識の画像
    private var image: String{
           "sign\(currentQuestionIndex)"
       }
    //CSVファイル格納配列
    @State private var csvArray: [String] = []
    //CSVファイルの問題格納配列
    @State private var quizArray: [String] = []
    //次の問題を表示させるための関数(CSVファイル用)
    func nextQuiz(){
        quizArray.removeAll()
           quizArray = csvArray[currentQuestionIndex].components(separatedBy: ",")
    }
    //前の問題を表示させるための関数(CSVファイル用)
    func lastQuiz(){
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
        Text("Current Question is \(currentQuestionIndex + 1)/25")
        Spacer()
            GeometryReader{ geo in
                Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width, height: 300)
            }
        Spacer()
            Text(String(describing: quizArray))
        Spacer()
            HStack{
                Button("Last Question")
                {
                    self.currentQuestionIndex = self.currentQuestionIndex - 1
                    if self.currentQuestionIndex == self.maxQuestionNumber || self.currentQuestionIndex == self.minQuestionNumber{
                        self.currentQuestionIndex = 0
                        }
                    self.lastQuiz()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .font(.body)
                    .cornerRadius(40)
                Spacer()
                Button("Next Question"){
                    self.currentQuestionIndex = self.currentQuestionIndex + 1
                    if self.currentQuestionIndex == self.maxQuestionNumber || self.currentQuestionIndex == self.minQuestionNumber{
                        self.currentQuestionIndex = 0
                    }
                    self.nextQuiz()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.body)
                    .cornerRadius(40)
                }
            }
        .navigationBarTitle("Sign Questions")
        }
       
        .onAppear{
            self.csvArray = self.loadCSV(fileName: "SignName")
            print(self.csvArray)
            self.quizArray = self.csvArray[self.currentQuestionIndex].components(separatedBy: ",")
        }
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView()
    }
}
