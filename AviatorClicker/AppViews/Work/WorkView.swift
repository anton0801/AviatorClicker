//
//  WorkView.swift
//  AviatorClicker
//
//  Created by Anton on 6/5/24.
//

import SwiftUI

struct WorkView: View {
    
    @Environment(\.presentationMode) var presMo
    
    @EnvironmentObject var playerData: PlayerData
    @StateObject var workData: WorkData = WorkData()
    
    @State var errorBuyUpgrade = false
    
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
                Image("work_label")
                    .resizable()
                    .frame(width: 200, height: 40)
                
                Spacer()
            }
            .padding()
            
            HStack {
                Text("\(playerData.microcircuits)")
                    .font(.custom("HoltwoodOneSC", size: 18))
                    .foregroundColor(Color.init(red: 225/255, green: 223/255, blue: 54/255, opacity: 1))
                Image("money")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.init(red: 69/255, green: 12/255, blue: 12/255, opacity: 0.45))
            )
            
            ScrollView {
                ForEach(workData.workItems, id: \.id) { workItem in
                    Button {
                        errorBuyUpgrade = !workData.buyWorkItem(workId: workItem.id)
                    } label: {
                        HStack {
                            Image(workItem.icon)
                                .resizable()
                                .frame(width: 100, height: 100)
                            VStack(alignment: .leading) {
                                Text(workItem.name)
                                    .font(.custom("HoltwoodOneSC", size: 20))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.init(red: 37/255, green: 44/255, blue: 51/255, opacity: 1))
                                Text(workItem.desc)
                                    .font(.custom("HoltwoodOneSC", size: 10))
                                    .foregroundColor(Color.init(red: 37/255, green: 44/255, blue: 51/255, opacity: 1))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            ZStack {
                                if playerData.microcircuits >= workItem.price {
                                    Image("can_buy_btn")
                                        .resizable()
                                        .frame(width: 100, height: 80)
                                } else {
                                    Image("cant_buy_btn")
                                        .resizable()
                                        .frame(width: 100, height: 80)
                                }
                                VStack(spacing: -5) {
                                    Text("Upgrade")
                                        .font(.custom("HoltwoodOneSC", size: 15))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                    HStack {
                                        Text("\(workItem.price)")
                                            .font(.custom("HoltwoodOneSC", size: 15))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                        Image("money")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }
                                }
                                .offset(y: -5)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(
            Image("upgrade_bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .alert(isPresented: $errorBuyUpgrade) {
            Alert(title: Text("Error!"),
                  message: Text("Upgrade item purchase error, looks like you don't have enough stars to buy it!"),
                  dismissButton: .cancel(Text("Ok!")))
        }
    }
}

#Preview {
    WorkView()
        .environmentObject(PlayerData())
}
