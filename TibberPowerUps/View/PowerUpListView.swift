//
//  PowerUpListView.swift
//  TibberPowerUps
//
//  Created by Waleerat Gottlieb on 2022-03-02.
//

import SwiftUI

struct PowerUpListView: View {
    @EnvironmentObject var powerUpVM: PowerUpsVM
    @State var powerUpItem: Response.PowerUpModel
    @State var isListView: Bool
    
    var body: some View {
        VStack{
            if isListView {
                NavigationLink(destination: PowerUpDetailView(powerUpItem: powerUpItem)) {
                    PowerUpPreview(powerUpItem: powerUpItem, isListView: isListView)
                }
            } else {
                PowerUpPreview(powerUpItem: powerUpItem, isListView: isListView)
            }
        }//:VStack
    }//:Body
}
 
struct PowerUpPreview: View {
    @State var powerUpItem: Response.PowerUpModel
    @State var isListView: Bool
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: powerUpItem.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                kTopBarBg
            }
            .frame(width: isListView ? 70 : 100, height: isListView ? 70 : 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .modifier(CustomShadowModifier())
           
            VStack(alignment: .leading, spacing: 10, content: {
                
                Text(powerUpItem.title)
                    .modifier(TextTitleModifier())
                
                Text(powerUpItem.description)
                    .modifier(TextAbstractModifier())
            }).padding(.leading, 5)
            //:VStack
            Spacer()
            if isListView {
                Image(systemName: "chevron.right")
                    .modifier(TextAbstractModifier())
            }
            
        }//:HStack
        .padding(isIpad() ? 20 : 7)
        .background(isListView ? .white : Color.gray.opacity(0))
        .clipShape(RoundedRectangle(cornerRadius: isListView ? 7: 0))
        .padding(isListView ? .horizontal : [.top, .bottom])
    }//:Body
}

