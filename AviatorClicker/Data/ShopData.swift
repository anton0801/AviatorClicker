import Foundation

class ShopData: ObservableObject {
    
    var playerData: PlayerData
    
    @Published var airplanes = ["plane_1", "plane_2", "plane_3"]
    @Published var maps = ["map_2", "map_3", "map_4"]
    @Published var microcircuits = ["microcircuits_1", "microcircuits_2", "microcircuits_3"]
    
    @Published var buyedItems = [String]()
    
    var prices = [
        "plane_1": 0,
        "plane_2": 20000,
        "plane_3": 20000,
        "map_2": 25000,
        "map_3": 30000,
        "map_4": 35000,
        "microcircuits_1": 40000,
        "microcircuits_2": 45000,
        "microcircuits_3": 50000
    ]
    
    var changeRates = [
        "microcircuits_1": 10000,
        "microcircuits_2": 12000,
        "microcircuits_3": 15000,
    ]
    
    init(playerData: PlayerData) {
        self.playerData = playerData
        
        var comps = UserDefaults.standard.string(forKey: "buyed_shop_items")?.components(separatedBy: ",") ?? []
        for comp in comps {
            if !comp.isEmpty {
                buyedItems.append(comp)
            }
        }
    }
    
    func buyShopItem(_ shopItemId: String) -> Bool {
        var shopItemPrice = prices[shopItemId]!
        if shopItemId.contains("microcircuits") {
            if shopItemPrice >= playerData.microcircuits {
                playerData.microcircuits += changeRates[shopItemId]!
                playerData.stars -= shopItemPrice
                return true
            }
        } else {
            if shopItemPrice >= playerData.stars {
                buyedItems.append(shopItemId)
                UserDefaults.standard.set(buyedItems.joined(separator: ","), forKey: "buyed_shop_items")
                playerData.microcircuits -= shopItemPrice
            }
        }
        return false
    }
    
}
