//
//  WebSocketClientApp.swift
//  WebSocketClient
//
//  Created by Aziz Bibitov on 06.01.2024.
//

import SwiftUI

@main
struct WebSocketClientApp: App {
    @StateObject var socketDelegate = WebsocketMaster()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(socketDelegate)
        }
    }
}
