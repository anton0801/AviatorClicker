import Foundation

class UpgradesData: ObservableObject {
    
    var playerData: PlayerData
    
    @Published var upgrades: [UpgradeItem] = [
        UpgradeItem(id: "speed", name: "Speed", desc: "The plane is getting faster by 0.01%", icon: "speed", price: 100),
        UpgradeItem(id: "strength", name: "Strength", desc: "The airplane becomes 0.01% stronger", icon: "strenght", price: 200),
        UpgradeItem(id: "fuel", name: "Fuel", desc: "The volume of fuel in the airplane increases by 0.01%", icon: "fuel", price: 300),
        UpgradeItem(id: "cost_per_click", name: "Cost per click", desc: "A player's click price will cost 1 more", icon: "cost_per_click", price: 400),
        UpgradeItem(id: "autoclick", name: "Autoclick", desc: "As long as the player is in the game on the player screen, the game will count clicks. Autoclick will become 1 more efficient", icon: "autoclick", price: 400)
    ]
    
    @Published var fuelLevel = UserDefaults.standard.integer(forKey: "upgrade_fuel") {
        didSet {
            UserDefaults.standard.set(fuelLevel, forKey: "upgrade_fuel")
        }
    }
    @Published var costPerClick = UserDefaults.standard.integer(forKey: "cost_per_click") {
        didSet {
            UserDefaults.standard.set(costPerClick, forKey: "cost_per_click")
        }
    }
    
    init(playerData: PlayerData) {
        self.playerData = playerData
        setUpPrices()
        if costPerClick == 0 {
            costPerClick = 1
        }
        if fuelLevel == 0 {
            fuelLevel = 1
        }
    }
    
    private func setUpPrices() {
        var upgradesTemp = [UpgradeItem]()
        upgradesTemp.append(contentsOf: upgrades)
        for (index, upgrade) in upgradesTemp.enumerated() {
            var upgradeCount = UserDefaults.standard.integer(forKey: "upgrade_\(upgrade.id)")
            if upgradeCount > 0 {
                upgrades[index] = UpgradeItem(id: upgrade.id, name: upgrade.name, desc: upgrade.desc, icon: upgrade.icon, price: upgrade.price + (upgradeCount * 100))
            }
        }
    }
    
    func buyUpgradeItem(upgradeId: String) -> Bool {
        let upgradeItem = upgrades.filter { $0.id == upgradeId }[0]
        if playerData.stars >= upgradeItem.price {
            if upgradeId == "fuel" {
                fuelLevel += 1
            } else if upgradeId == "cost_per_click" {
                costPerClick += 1
            } else if upgradeId == "autoclick" {
                UserDefaults.standard.set(true, forKey: "autoclick")
                upgrades[4] = UpgradeItem(id: upgradeItem.id, name: upgradeItem.name, desc: upgradeItem.desc, icon: upgradeItem.icon, price: -1)
            }
            playerData.stars -= upgradeItem.price
            return true
        }
        return false
    }
    
    func canBuyUpgrade(upgrade: UpgradeItem) -> Bool {
        if upgrade.id == "autoclick" {
            return UserDefaults.standard.bool(forKey: "upgrade_autoclick")
        }
        return true
    }
    
}
