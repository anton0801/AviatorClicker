import Foundation

class PlayerData: ObservableObject {
    
    @Published var stars: Int = UserDefaults.standard.integer(forKey: "stars") {
        didSet {
            UserDefaults.standard.set(stars, forKey: "stars")
        }
    }
    
    @Published var microcircuits: Int = UserDefaults.standard.integer(forKey: "microcircuits") {
        didSet {
            UserDefaults.standard.set(microcircuits, forKey: "microcircuits")
        }
    }
    
    @Published var selectedMap = UserDefaults.standard.string(forKey: "map_selected") {
        didSet {
            UserDefaults.standard.set(selectedMap, forKey: "map_selected")
        }
    }
    
    @Published var selectedPlane = UserDefaults.standard.string(forKey: "plane_selected") {
        didSet {
            UserDefaults.standard.set(selectedPlane, forKey: "plane_selected")
        }
    }
    
}
