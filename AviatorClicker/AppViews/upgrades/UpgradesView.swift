import SwiftUI
import AVFoundation

struct UpgradesView: View {
    
    @Environment(\.presentationMode) var presMo
    
    @State var upgradeSound: AVAudioPlayer?
    
    @EnvironmentObject var playerData: PlayerData
    @EnvironmentObject var upgradesData: UpgradesData
    
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
                Image("upgrades_label")
                    .resizable()
                    .frame(width: 200, height: 40)
                
                Spacer()
            }
            .padding()
            
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
            
            ScrollView {
                ForEach(upgradesData.upgrades, id: \.id) { upgrade in
                    Button {
                        errorBuyUpgrade = !upgradesData.buyUpgradeItem(upgradeId: upgrade.id)
                        upgradeAudio()
                    } label: {
                        HStack {
                            Image(upgrade.icon)
                                .resizable()
                                .frame(width: 100, height: 100)
                            VStack(alignment: .leading) {
                                Text(upgrade.name)
                                    .font(.custom("HoltwoodOneSC", size: 20))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.init(red: 37/255, green: 44/255, blue: 51/255, opacity: 1))
                                Text(upgrade.desc)
                                    .font(.custom("HoltwoodOneSC", size: 10))
                                    .foregroundColor(Color.init(red: 37/255, green: 44/255, blue: 51/255, opacity: 1))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            if upgradesData.canBuyUpgrade(upgrade: upgrade) || (upgrade.id == "autoclick" && !upgradesData.canBuyUpgrade(upgrade: upgrade)) {
                                ZStack {
                                    if playerData.stars >= upgrade.price {
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
                                            Text("\(upgrade.price)")
                                                .font(.custom("HoltwoodOneSC", size: 15))
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(.white)
                                            Image("star")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                    .offset(y: -5)
                                }
                            } else {
                                Image("max_upgrade_btn")
                                    .resizable()
                                    .frame(width: 100, height: 80)
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
    
    private func upgradeAudio() {
        if let soundURL = Bundle.main.url(forResource: "upgrade_progress_sound", withExtension: "mp3") {
            do {
                upgradeSound = try AVAudioPlayer(contentsOf: soundURL)
                upgradeSound?.play()
            } catch {
            }
        } else {
        }
    }
    
}

#Preview {
    VStack {
        var playerData = PlayerData()
        UpgradesView()
            .environmentObject(playerData)
            .environmentObject(UpgradesData(playerData: playerData))
    }
}
