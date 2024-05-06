import SwiftUI

struct ShopView: View {
    
    @Environment(\.presentationMode) var presMo
    
    @EnvironmentObject var playerData: PlayerData
    @EnvironmentObject var mapTerainData: MapTerainData
    
    @State var shopData: ShopData?
    
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
                Spacer()
                
                Image("shop_label")
                    .resizable()
                    .frame(width: 110, height: 40)
                
                Spacer()
                
                VStack {
                    HStack {
                        HStack {
                            Text("\(playerData.stars)")
                                .font(.custom("HoltwoodOneSC", size: 18))
                                .foregroundColor(Color.init(red: 225/255, green: 223/255, blue: 54/255, opacity: 1))
                            Image("star")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(Color.init(red: 69/255, green: 12/255, blue: 12/255, opacity: 0.45))
                        )
                    }
                    
                    HStack {
                        HStack {
                            Text("\(playerData.microcircuits)")
                                .font(.custom("HoltwoodOneSC", size: 18))
                                .foregroundColor(Color.init(red: 167/255, green: 228/255, blue: 255/255, opacity: 1))
                            Image("money")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(Color.init(red: 69/255, green: 12/255, blue: 12/255, opacity: 0.45))
                        )
                    }
                }
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Image("airplanes_label")
                        .resizable()
                        .frame(width: 120, height: 40)
                    HStack {
                        ForEach(shopData?.airplanes ?? [], id: \.self) { airplane in
                            VStack {
                                Image("shop_\(airplane)")
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                if playerData.selectedPlane == airplane {
                                    Image("used_btn")
                                        .resizable()
                                        .frame(width: 110, height: 50)
                                        .offset(y: -15)
                                } else {
                                    if shopData?.buyedItems.contains(airplane) == true {
                                        Button {
                                            playerData.selectedPlane = airplane
                                        } label: {
                                            Image("use_btn")
                                                .resizable()
                                                .frame(width: 110, height: 50)
                                        }
                                        .offset(y: -15)
                                    } else {
                                        Button {
                                            shopData?.buyShopItem(airplane)
                                        } label: {
                                            ZStack {
                                                Image("buy_btn")
                                                    .resizable()
                                                    .frame(width: 110, height: 50)
                                                VStack(spacing: -5) {
                                                    Text("Buy")
                                                        .font(.custom("HoltwoodOneSC", size: 15))
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.white)
                                                    HStack {
                                                        Text("\(shopData?.prices[airplane]! ?? 20000)")
                                                            .font(.custom("HoltwoodOneSC", size: 13))
                                                            .multilineTextAlignment(.center)
                                                            .foregroundColor(.white)
                                                        Image("money")
                                                            .resizable()
                                                            .frame(width: 24, height: 24)
                                                    }
                                                }
                                                .offset(y: -5)
                                            }
                                        }
                                        .offset(y: -15)
                                    }
                                }
                            }
                            .padding(4)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Image("platforms_label")
                        .resizable()
                        .frame(width: 190, height: 40)
                    HStack {
                        ForEach(shopData?.maps ?? [], id: \.self) { map in
                            VStack {
                                Image("shop_\(map)")
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                if mapTerainData.selectedMap == map {
                                    Image("used_btn")
                                        .resizable()
                                        .frame(width: 110, height: 50)
                                        .offset(y: -15)
                                } else {
                                    if shopData?.buyedItems.contains(map) == true {
                                        Button {
                                            mapTerainData.selectedMap = map
                                        } label: {
                                            Image("use_btn")
                                                .resizable()
                                                .frame(width: 110, height: 50)
                                        }
                                        .offset(y: -15)
                                    } else {
                                        Button {
                                            shopData?.buyShopItem(map)
                                        } label: {
                                            ZStack {
                                                Image("buy_btn")
                                                    .resizable()
                                                    .frame(width: 110, height: 50)
                                                VStack(spacing: -5) {
                                                    Text("Buy")
                                                        .font(.custom("HoltwoodOneSC", size: 15))
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.white)
                                                    HStack {
                                                        Text("\(shopData?.prices[map]! ?? 20000)")
                                                            .font(.custom("HoltwoodOneSC", size: 13))
                                                            .multilineTextAlignment(.center)
                                                            .foregroundColor(.white)
                                                        Image("money")
                                                            .resizable()
                                                            .frame(width: 24, height: 24)
                                                    }
                                                }
                                                .offset(y: -5)
                                            }
                                        }
                                        .offset(y: -15)
                                    }
                                }
                            }
                            .padding(4)
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Image("microcircuits_label")
                        .resizable()
                        .frame(width: 270, height: 40)
                    HStack {
                        ForEach(shopData?.microcircuits ?? [], id: \.self) { microcircuit in
                            VStack {
                                Image("\(microcircuit)")
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                Button {
                                    shopData?.buyShopItem(microcircuit)
                                } label: {
                                    ZStack {
                                        Image("buy_btn")
                                            .resizable()
                                            .frame(width: 110, height: 50)
                                        VStack(spacing: -5) {
                                            Text("Buy")
                                                .font(.custom("HoltwoodOneSC", size: 15))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                            HStack {
                                                Text("\(shopData?.prices[microcircuit]! ?? 20000)")
                                                    .font(.custom("HoltwoodOneSC", size: 13))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.white)
                                                Image("star")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                            }
                                        }
                                        .offset(y: -5)
                                    }
                                }
                                .offset(y: -15)
                            }
                            .padding(4)
                        }
                    }
                }
            }
        }
        .background(
            Image("shop_bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .onAppear {
            shopData = ShopData(playerData: playerData)
        }
    }
}

#Preview {
    ShopView()
        .environmentObject(PlayerData())
        .environmentObject(MapTerainData())
}
