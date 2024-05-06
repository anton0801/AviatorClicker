import Foundation

class MapTerainData: ObservableObject {
    
    var maps: [String] = ["map_1", "map_2", "map_3", "map_4"]
    
    @Published var selectedMap = "map_1"
    
}
