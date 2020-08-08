//
//  ContentView.swift
//  06 - Color Cycle
//
//  Created by Kevin Paul on 8/5/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var hexColorString = ""
    
    @State private var buttonText = "Start"
    
    var hexColor: Color {
        let UIntString = hexColorString
        let color: UInt32 = UInt32(UIntString, radix: 16) ?? 0xffffff
        let redComponent = (color & 0xFF0000) >> 16
        let greenComponent = (color & 0x00FF00) >> 8
        let blueComponent = color & 0x0000FF
        let myColor = Color(red: Double(redComponent) / 255, green: Double(greenComponent) / 255, blue: Double(blueComponent) / 255)
        
        return myColor
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.white,.gray,.gray,.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                
                //
                if buttonText == "Start" {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 300)
                        .foregroundColor(hexColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 1)
                    )
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 300)
                        .foregroundColor(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 1)
                    )
                }
                
                
                
                TextField("Enter a hex color #bec8c7", text: $hexColorString)
                    .onReceive(hexColorString.publisher.collect()) {
                        self.hexColorString = String($0.prefix(6))
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
                .foregroundColor(.primary)
                .padding()
                .padding([.leading,.trailing], 20)
                
                Spacer()
                
                Button(action: {
                    if self.buttonText == "Start" {
                        self.buttonText = "Stop"
                    } else {
                        self.buttonText = "Start"
                    }
                    
                }) {
                    Text(self.buttonText)
                        .overlay(
                            Circle()
                                .stroke()
                                .frame(width: 150, height: 150)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.white)
                
                Spacer()
            }
        }
        
    }
    //methods
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
