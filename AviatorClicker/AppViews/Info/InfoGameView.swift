//
//  InfoGameView.swift
//  AviatorClicker
//
//  Created by Anton on 6/5/24.
//

import SwiftUI

struct InfoGameView: View {
    
    @Environment(\.presentationMode) var presMo
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presMo.wrappedValue.dismiss()
                } label: {
                    Image("close_btn")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Image("info_game")
                    .resizable()
                    .frame(width: 200, height: 40)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Image("info_content")
                .resizable()
                .frame(width: 350, height: 190)
            
            Spacer()
        }
        .background(
            Image("back_menu")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    InfoGameView()
}
