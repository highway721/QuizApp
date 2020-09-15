//
//  TextBookView.swift
//  QuizApp
//
//  Created by Yusuke Tomatsu on 2020/09/07.
//  Copyright © 2020 Yusuke Tomatsu. All rights reserved.
//

import SwiftUI

struct TextBookView: View {
    var body: some View {
        NavigationView{
        Text("TextBook View")
        .navigationBarTitle("TextBook")
        }
        
    }
}

struct TextBookView_Previews: PreviewProvider {
    static var previews: some View {
        TextBookView()
    }
}
