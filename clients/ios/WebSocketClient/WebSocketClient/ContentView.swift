//
//  ContentView.swift
//  WebSocketClient
//
//  Created by Aziz Bibitov on 06.01.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var socketMaster: WebsocketMaster
    var body: some View {
        ScrollView {
            VStack {
                Text("isConnected webSocket: \(String(socketMaster.isConnected))")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                
                Button {
                    print("btn: Send String")
                    socketMaster.sendString()
                } label: {
                    Text("Send String")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.green)
                        .cornerRadius(15)
                }
                
                Button {
                    print("btn: Send Data")
                    socketMaster.sendData()
                } label: {
                    Text("Send Data")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.green)
                        .cornerRadius(15)
                }
                
                Button {
                    print("btn: Send Ping")
                    socketMaster.sendPing()
                } label: {
                    Text("Send Ping frame")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.green)
                        .cornerRadius(15)
                }
                
                Button {
                    print("btn: Send Pong")
                    socketMaster.sendPong()
                } label: {
                    Text("Send Pong Frame")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.green)
                        .cornerRadius(15)
                }

            }
        }
        .refreshable {
            print("awdwd")
            socketMaster.connect()
        }
        .onAppear {
            socketMaster.connect()
        }
    }
}
