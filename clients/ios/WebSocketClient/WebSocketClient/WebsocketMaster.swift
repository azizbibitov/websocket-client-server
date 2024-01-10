//
//  WebsocketMaster.swift
//  WebSocketClient
//
//  Created by Aziz Bibitov on 06.01.2024.
//

import Foundation
import Starscream

class WebsocketMaster: ObservableObject, WebSocketDelegate {
    
    var socket: WebSocket!
    @Published var isConnected: Bool = false
    
    func connect() {
        var request = URLRequest(url: URL(string: "http://localhost:3000")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendString() {
        socket.write(string: "Hi from iOS client!!!")
    }
    
    func sendData() {
        let dictionary: [String: String] = ["aziz": "bibitov", "shovket": "shohradov"]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            print(jsonData)
            socket.write(data: jsonData)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func sendPing() {
        socket.write(ping: Data())
    }
    
    func sendPong() {
        socket.write(pong: Data())
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        print("new Event !!!!", event)
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        case .peerClosed:
            isConnected = false
            print("peer is closed")
            break
        }
    }
    
    func handleError(_ error: Error?) {
        print("error ======", error?.localizedDescription ?? "")
    }
    
    
}
