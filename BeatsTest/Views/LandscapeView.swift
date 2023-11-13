//
//  LandscapeView.swift
//  BeatsTest
//
//  Created by Rafa (Ruffles) on 09/11/23.
//

import SwiftUI

struct LandscapeView: View {
    @ObservedObject var configController = ConfigController.shared
    @ObservedObject var compassController : CompassController
    let bigPadding : Double = 10
    let smallPadding : Double = 5
    
    var body: some View {
        let screenBounds = UIScreen.main.bounds
        let screenSize = calcScreenSize(screenBounds: screenBounds)
        ZStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(.white)
                    .opacity(0.1)
                HStack(alignment: .center, spacing: 0){
                    Spacer()
                    ForEach((2...compassController.compass.pulseCount), id: \.self){ _ in
                        Spacer()
                        Rectangle()
                            .stroke(Color(red: 0.61, green: 0.61, blue: 0.61), style: StrokeStyle(lineWidth: 1, dash: [3]))
                            .frame(width: 1)
                            .frame(maxHeight: .infinity)
                        Spacer()
                    }
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0){
                    let notes = compassController.compass.notes
                    ForEach(0..<notes.count, id: \.self) { i in
                        NoteView(nota: notes[i])
                            .padding(.leading, leadingNotePadding(notes: notes, maxIndex: i))
                            .padding(.trailing, trailingNotePadding(notes: notes, maxIndex: i))
                            .frame(width: noteWidth(screenSize: screenSize, nota: notes[i]), height: noteHeight(screenSize: screenSize))
//                        if spacerCheck(notes: notes, maxIndex: i) {
//                            Spacer()
//                                .background(.red)
//                                .padding(.leading, 20)
//                        }
                    }
                    .padding(.horizontal, 0)
                    Spacer(minLength: 0)
                }.padding(.horizontal, 0)
            }
            .frame(width: screenSize.width*0.8, height: screenSize.height*0.5)
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .circular))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func calcScreenSize(screenBounds: CGRect) -> CGRect {
        if configController.config.orientationLock {
            return CGRect(origin: screenBounds.origin, size: CGSize(width: screenBounds.height, height: screenBounds.width))
        }
        return screenBounds
    }
    
    func noteWidth(screenSize: CGRect, nota: Note) -> Double {
        let pulseCount = Double(compassController.compass.pulseCount)
        let pulseDuration = Double(compassController.compass.pulseDuration)
        return screenSize.width*0.8*nota.duration*pulseDuration/pulseCount
    }
    func noteHeight(screenSize: CGRect) -> Double {
        return screenSize.height*0.4
    }
    func sizeCount(notes:[Note], maxIndex: Int) -> Double {
        var sizeCount : Double = 0
        for i in 0...maxIndex {
            sizeCount += notes[i].duration
        }
        return sizeCount
    }
    func spacerCheck(notes: [Note], maxIndex: Int) -> Bool {
        var sizeCount : Double = 0
        for i in 0...maxIndex {
            sizeCount += notes[i].duration
        }
        
        let pulseCount = Double(compassController.compass.pulseCount)
        let remainderIsZero = sizeCount.truncatingRemainder(dividingBy:1.0/pulseCount).isZero
        
        return remainderIsZero && sizeCount != 0.0 || notes[maxIndex].duration >= 0.25
    }
    func leadingNotePadding(notes:[Note], maxIndex: Int) -> Double {
        if maxIndex == 0 {
            return bigPadding
        }
        
        return notePadding(notes: notes, maxIndex: maxIndex-1)
    }
    func trailingNotePadding(notes:[Note], maxIndex: Int) -> Double {
        if maxIndex == notes.count-1 {
            return bigPadding
        }
        
        return notePadding(notes: notes, maxIndex: maxIndex)
    }
    func notePadding(notes:[Note], maxIndex: Int) -> Double {
        let sizeCount = sizeCount(notes: notes, maxIndex: maxIndex)
        let pulseCount = Double(compassController.compass.pulseCount)
        let remainderIsZero = sizeCount.truncatingRemainder(dividingBy:1.0/pulseCount).isZero
        
        return remainderIsZero ? bigPadding : smallPadding
    }
}

#Preview {
    LandscapeView(compassController: CompassController())
}
