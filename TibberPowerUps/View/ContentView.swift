//
//  ContentView.swift
//  TibberPowerUps
//
//  Created by Waleerat Gottlieb on 2022-03-02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var powerUpVM: PowerUpsVM
    
    @State var index = 0
    
    var body: some View {
        ZStack {
            BodyColor()
            VStack {
                NavigationColor()
                VStack{
                    // MARK: - Tab Selection
                    HStack(spacing: 0){
                        Text("Connected")
                            .modifier(TabSelecterModifier(isActive: self.index == 0))
                            .onTapGesture {
                                withAnimation(.default){
                                    self.index = 0
                                }
                            }
                        
                        Text("Disconnected")
                            .modifier(TabSelecterModifier(isActive: self.index == 1))
                            .onTapGesture {
                                withAnimation(.default){
                                    self.index = 1
                                }
                            }
                    }//:HStack
                    .frame(width: isIpad() ? getScreen().width * 0.5 : getScreen().width * 0.98)
                    .background(Color.black.opacity(0.03))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom,25)
                    
                    // MARK: - Preview Selection
                    TabView(selection: self.$index){
                        PowerUpItemPreveiw(isConnected: true).tag(0)
                        PowerUpItemPreveiw(isConnected: false).tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    Spacer(minLength: 0)
                }//:VStack
                .padding(.top)
                
                Spacer()
            }//:VStack
        }//:ZStack
        .modifier(NavigationBarTitleModifier(titleBar: "Power-ups"))
        .ignoresSafeArea(.all, edges: [.trailing])
        .padding(0)
         
    }
}

 
struct PowerUpItemPreveiw: View {
    @EnvironmentObject var powerUpVM: PowerUpsVM
    @State var isConnected: Bool
    @State var items: [Response.PowerUpModel] = []
    
    var body: some View {
        VStack{
            if (powerUpVM.getPowerUpItems(isConnected: isConnected).count > 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(powerUpVM.getPowerUpItems(isConnected: isConnected)) { powerupItem in
                        PowerUpListView(powerUpItem: powerupItem, isListView: true)
                    }
                }
            } else {
                Image("tibber-logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                Text(isConnected ? "No Connected" : "No Disconnected")
                Spacer()
            }
        }
    }
}
