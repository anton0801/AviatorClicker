import SwiftUI
import AVFoundation

struct AirplaneGameView: View {
    
    @State var audioPlayer: AVAudioPlayer?
    @State var tapAudio: AVAudioPlayer?
    
    @EnvironmentObject var mapTerainData: MapTerainData
    @EnvironmentObject var playerData: PlayerData
    var upgradesData: UpgradesData {
        get {
            return UpgradesData(playerData: playerData)
        }
    }
    
    @State var planeFuel = UserDefaults.standard.double(forKey: "plane_fuel_available") {
        didSet {
            UserDefaults.standard.set(planeFuel, forKey: "plane_fuel_available")
        }
    }
    
    @State var addPoints = false
    
    @State var soundOn = true
    @State var timeToHide: Double = 0
    
    @State var errorGameClick = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        if soundOn {
                            offAudio()
                        } else {
                            onAudio()
                        }
                    } label: {
                        if soundOn {
                            Image("sound_on_btn")
                                 .resizable()
                                 .frame(width: 50, height: 50)
                        } else {
                            Image("sound_off_btn")
                                 .resizable()
                                 .frame(width: 50, height: 50)
                        }
                    }
                    
                    Spacer()
                    
                    if addPoints {
                        Text("+\(1 * upgradesData.costPerClick)")
                            .font(.custom("HoltwoodOneSC", size: 18))
                            .foregroundColor(.white)
                            .animation(.easeInOut(duration: 0.1))
                    }
                    
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
                
                ZStack(alignment: .leading) {
                    Image("plane_bak_bg")
                        .resizable()
                        .frame(width: 360, height: 25)
                    Image("plane_bak_bg_100")
                        .resizable()
                        .frame(width: 354 * (planeFuel / 100), height: 20)
                        .cornerRadius(24)
                        .padding([.leading, .trailing], 4)
                }
                
                Spacer()
                
                Button {
                    clickAction()
                } label: {
                    Image(playerData.selectedPlane ?? "plane_1")
                        .resizable()
                        .frame(width: 380, height: 300)
                }
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: UpgradesView()
                        .environmentObject(playerData)
                        .environmentObject(mapTerainData)
                        .environmentObject(upgradesData)
                        .navigationBarBackButtonHidden(true)) {
                        Image("upgrade_btn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: WorkView()
                        .environmentObject(playerData)
                        .navigationBarBackButtonHidden(true)) {
                        Image("job_btn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ShopView()
                        .environmentObject(playerData)
                        .environmentObject(mapTerainData)
                        .navigationBarBackButtonHidden(true)) {
                        Image("shop_btn")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                .padding()
                .background(
                    Image("bttn_bg")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 130)
                )
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                Image(mapTerainData.selectedMap)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .alert(isPresented: $errorGameClick) {
                Alert(title: Text("Error!"),
                      message: Text("Fuel has run out, you must wait 3 hours for a full tank to be restored"),
                      dismissButton: .cancel(Text("Ok!")))
            }
            .onAppear {
                onAudio()
                soundOn = true
            }
            .onDisappear {
                offAudio()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func clickAction() {
        if planeFuel > 0.0 {
            addPoints = true
            playerData.stars += 1 * upgradesData.costPerClick
            planeFuel += ((1.0 * Double(upgradesData.fuelLevel)) / 100) - 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                addPoints = false
            }
            UserDefaults.standard.set(Date(), forKey: "last_click_time")
            if tapAudio == nil {
                if let soundURL = Bundle.main.url(forResource: "tap_sound", withExtension: "mp3") {
                    do {
                        tapAudio = try AVAudioPlayer(contentsOf: soundURL)
                    } catch {
                    }
                }
            }
            
            tapAudio?.play()
        } else {
            errorGameClick = true
        }
    }
    
    private func onAudio() {
        if let soundURL = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
                soundOn = true
            } catch {
            }
        } else {
        }
    }
    
    private func offAudio() {
        audioPlayer?.pause()
        audioPlayer?.stop()
        audioPlayer = nil
        soundOn = false
    }
    
}

#Preview {
    AirplaneGameView()
        .environmentObject(MapTerainData())
        .environmentObject(PlayerData())
}
