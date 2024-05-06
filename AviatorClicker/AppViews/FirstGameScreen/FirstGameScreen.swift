import SwiftUI

struct FirstGameScreen: View {
    
    @StateObject var mapData = MapTerainData()
    @StateObject var playerData = PlayerData()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("app_name")
                  .resizable()
                  .frame(width: 300, height: 100)
                  .padding(.top)

                Spacer()
                
                NavigationLink(destination: AirplaneGameView()
                    .environmentObject(playerData)
                    .environmentObject(mapData)
                    .navigationBarBackButtonHidden(true)) {
                    Image("play_btn")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Image("info_btn")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding()
            }
            .background(
                Image("back_menu")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .onAppear {
                if !UserDefaults.standard.bool(forKey: "is_not_first_launch") {
                    playerData.selectedPlane = "plane_1"
                    mapData.selectedMap = "map_1"
                    UserDefaults.standard.set(true, forKey: "is_not_first_launch")
                    UserDefaults.standard.set(100.0, forKey: "plane_fuel_available")
                }
                if let lastClickDate = UserDefaults.standard.object(forKey: "lastClickDate") as? Date {
                    let currentDate = Date()
                    let timeDiff = currentDate.timeIntervalSince(lastClickDate)
                    let totalSecondsInThreeHours: TimeInterval = 3 * 60 * 60
                    let percentage = (timeDiff / totalSecondsInThreeHours) * 100
                    
                    if UserDefaults.standard.bool(forKey: "") {
                        playerData.stars += Int(timeDiff) * UserDefaults.standard.integer(forKey: "upgrade_autoclick")
                    }
                    
                    let availableFuel = UserDefaults.standard.double(forKey: "plane_fuel_available")
                    if percentage >= 100 {
                        UserDefaults.standard.set(100.0, forKey: "plane_fuel_available")
                    } else {
                        if availableFuel + percentage >= 100 {
                            UserDefaults.standard.set(100.0, forKey: "plane_fuel_available")
                        } else {
                            UserDefaults.standard.set(availableFuel + percentage, forKey: "plane_fuel_available")
                        }
                    }
                } else {
                }
            }
        }
    }
}

#Preview {
    FirstGameScreen()
}
