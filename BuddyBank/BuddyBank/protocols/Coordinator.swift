//
//  Coordinator.swift
//  BuddyBank
//
//  Created by Max on 17/12/22.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func startApp()
}
