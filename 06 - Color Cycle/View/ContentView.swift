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
    
    @State private var colorCycleUInt: [UInt32] = []
    @State private  var colorCycleColor: [Color] = []
    @State private var timer: Timer?
    @State private var timerValue = 0
    
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
                        .foregroundColor(colorCycleColor[timerValue])
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
                        self.buildColorCycle(from: self.hexColorString)
                        self.convertToColors(from: self.colorCycleUInt)
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            //increment a value
                            if self.timerValue < 7 {
                                self.timerValue += 1
                            } else {
                                self.timerValue = 0
                            }
                        }
                        self.buttonText = "Stop"
                    } else {
                        self.colorCycleUInt = []
                        self.colorCycleColor = []
                        self.timer?.invalidate()
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
    func buildColorCycle(from colorString: String) {
        let hexColorString = colorString
        let initialColor: UInt32 = UInt32(hexColorString, radix: 16) ?? 0xffffff
        
        colorCycleUInt.append(initialColor)
        for i in 1..<8 {
            colorCycleUInt.append(initialColor + UInt32((25 * i)))
        }
    }
    
    func convertToColors(from UIntColor: [UInt32]) {
        
        for color in colorCycleUInt {
            let redComponent = (color & 0xFF0000) >> 16
            let greenComponent = (color & 0x00FF00) >> 8
            let blueComponent = color & 0x0000FF
            let myColor = Color(red: Double(redComponent) / 255, green: Double(greenComponent) / 255, blue: Double(blueComponent) / 255)
            
            colorCycleColor.append(myColor)
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
