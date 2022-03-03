//
//  ButtonActionView.swift
//  TibberPowerUps
//
//  Created by Waleerat Gottlieb on 2022-03-02.
//

import SwiftUI

struct ButtonActionView: View {
    
    @Binding var buttonLabel: String
    @State var backgroundColor:Color = kTopBarBg
    @Binding var isActive:Bool
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Text(buttonLabel)
                .font(.system(size: isIpad() ? 25 : 16 ,weight: .regular, design: .rounded))
                .foregroundColor(isActive ? .white : kTitleColor)
                .padding()
                .frame(width: isIpad() ? 350 : 200)
                .background(isActive ? kTopBarBg : kTitleColor.opacity(0.1))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(isActive ? kTopBarBg : kBorderColor, lineWidth: 2))
                //.shadow(radius: 2)
        }).padding(3)
    }
}

struct BodyColor: View {
    var body: some View {
        Color.gray
            .opacity(0.1)
            .ignoresSafeArea()
    }
}

struct NavigationColor: View {
    var body: some View {
        Rectangle()
            .frame(height: 0)
            .background(Color("TopBarColor"))
    }
}
