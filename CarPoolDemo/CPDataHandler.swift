//
//  CPDataHandler.swift
//  CarPoolDemo
//
//  Created by Sriram Reddy on 3/24/17.
//  Copyright © 2017 SGS Inc. All rights reserved.
//

import Foundation
import UIKit
class CPDataHandler {
    static let shared = CPDataHandler()
    var demoEntities: [CPDemoEntity] = []
    var rideOptionEntities: [CPRideOptionEntity] = []
    
    func setUpData(completionHandler:@escaping () -> Void) {
        let queue = DispatchQueue(label: "com.carpool.serialQueue")
        queue.async {
            self.setUpDemoEntities()
            self.setUpRideOptions()
            completionHandler()
        }
    }
    
    private func setUpDemoEntities() {
        let entity1 = CPDemoEntity()
        entity1.title = "Share your rides"
        entity1.description = "Share your rides to save your money"
        entity1.image = #imageLiteral(resourceName: "demo_share")
        
        let entity2 = CPDemoEntity()
        entity2.title = "Reduce Pollution"
        entity2.description = "Reducing usage o fcars helps the environment"
        entity2.image = #imageLiteral(resourceName: "demo_pollution")
        
        let entity3 = CPDemoEntity()
        entity3.title = "Have a Fun trip"
        entity3.description = "Going along with different people establishes connections and makes ride stress free"
        entity3.image = #imageLiteral(resourceName: "demo_fun")
        demoEntities = [entity1, entity2, entity3]
    }
    
    private func setUpRideOptions() {
        let entity1 = CPRideOptionEntity()
        entity1.title = "Ride Share"
        entity1.description = "One + One"
        entity1.image = #imageLiteral(resourceName: "ride_share")
        entity1.activeStars = 5
        
        let entity2 = CPRideOptionEntity()
        entity2.title = "Personal"
        entity2.description = "Private"
        entity2.image = #imageLiteral(resourceName: "ride_personnel")
        entity2.activeStars = 4
        
        let entity3 = CPRideOptionEntity()
        entity3.title = "The friendly bunch"
        entity3.description = "Friends"
        entity3.image = #imageLiteral(resourceName: "ride_friends")
        entity3.activeStars = 4
        
        rideOptionEntities = [entity1, entity2, entity3]
    }
    
}
