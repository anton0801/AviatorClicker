//
//  WorkData.swift
//  AviatorClicker
//
//  Created by Anton on 6/5/24.
//

import Foundation

class WorkData: ObservableObject {
    
    var workItems = [
        UpgradeItem(id: "rentals", name: "Rentals", desc: "You're renting out your airplane", icon: "work_rentails", price: 100),
        UpgradeItem(id: "photoshoot", name: "Photo shoot", desc: "You give up your airplane for the photo shoot", icon: "work_photo_shoot", price: 200),
        UpgradeItem(id: "race", name: "Race", desc: "You're giving your airplane to a local air race", icon: "work_race", price: 300),
        UpgradeItem(id: "filmmaking", name: "Filmmaking", desc: "You're giving up your plane to make a movie", icon: "work_filmaking", price: 400),
        UpgradeItem(id: "aviacompetition", name: "Avia competition", desc: "You're giving up your plane to make a movie", icon: "work_avia_competition", price: 500)
    ]
    
    func buyWorkItem(workId: String) -> Bool {
        return false
    }
    
}
