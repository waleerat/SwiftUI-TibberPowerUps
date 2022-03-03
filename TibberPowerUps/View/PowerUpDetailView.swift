//
//  PowerUpDetailView.swift
//  TibberPowerUps
//
//  Created by Waleerat Gottlieb on 2022-03-02.
//

import SwiftUI

struct PowerUpDetailView: View {
    @EnvironmentObject var powerUpVM: PowerUpsVM
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    @State var powerUpItem: Response.PowerUpModel
    @State var isConnected:Bool = false
    
    var body: some View {
        ZStack {
            BodyColor()
            VStack {
                NavigationColor()
                VStack{
                    PowerUpListView(powerUpItem: powerUpItem, isListView: false)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            ButtonActionView(buttonLabel: .constant("Disconnect from Tibber") , isActive: $isConnected, action: {
                                //isConnected.toggle()
                            })
                            ButtonActionView(buttonLabel: .constant("Buy at Tibber Store") , isActive: .constant(true), action: {
                                openURL(URL(string: powerUpItem.storeUrl)!)
                            })
                        }//:VStack
                        VStack(alignment: .leading, spacing: 10){
                            Text("More About \(powerUpItem.title)")
                                .modifier(TextTitleModifier())
                                .padding(.bottom, 7)
                            Text(powerUpItem.longDescription)
                                .modifier(TextDescriptionModifier())
                        }
                        
                        .padding()
                    }//:ScrollView
                }
                Spacer()
            }//:VStack
        }//:ZStack
        .padding(0)
        .modifier(NavigationBarTitleModifier(titleBar: powerUpItem.title))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "arrow.backward")
                            .font(.system(size: isIpad() ? 30 : 18 ,weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                    }.foregroundColor(.white)
                }
            }
        }
        .onAppear {
            isConnected = powerUpItem.connected
        }
        //:VStack
    }
}
