//
//  ContentView.swift
//  Sh*tHead
//
//  Created by Or Zino on 20/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    let MAXCARDS = 53
    @State var pile = 0
    @State var prevGame = true
    @State var player1 = Array(repeating: 0, count: 53)
    @State var player2 = Array(repeating: 0, count: 53)
    //@State var pack = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14]
    @State var pack = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6]
    @State var pileArray = Array(repeating: 0, count: 53)
    @State var packCounter = 52
    @State var finalplayer1 = Array(repeating: 0, count: 3)
    @State var finalplayer2 = Array(repeating: 0, count: 3)
    @State var flipCardplayer1 = Array(repeating: 0, count: 3)
    @State var flipCardplayer2 = Array(repeating: 0, count: 3)
    
    @State var player2Empty = true
    @State var player2FinalEmpty = false
    @State var startGame = false
    
    @State var duplicate = 0
    @State var countDupl = 1
    @State var cardsInHand = 3
    @State var cardsInHand2 = 3
    
    @State var specialCard = 0
    @State var tmpPile = 0
    @State var arrow = "down"
    @State var turnSucc = false
    //@State var btn
    
    
    var body: some View {
        
//        self.player1 = 6//Int.random(in: pack)

        ZStack{
            Image("Background")
                .ignoresSafeArea()
            VStack() {
                Spacer()
                HStack(alignment: .center){
                    
                    Text ("Deak: " + String(packCounter))
                    Spacer()
                    if arrow == "up"{
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 20.0, height: 30.0)
                            .onAppear() {
                                Task {
                                    do {
                                        let result = try await player2Trun()
                                        arrow = result
                                    }catch {
                                        print("Error fetching data")
                                    }
                                }
                            }
                    } else if arrow == "down"{
                        Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 20.0, height: 30.0)
                        
                    } else if arrow == "player1win" {
                        Image("prize1")
                            .resizable()
                            .frame(width: 20.0, height: 30.0)
                        //print("player 1 WIN!!!!")
                        
                    } else if arrow == "player2win" {
                        Image("prize2")
                            //.confettiCannon
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 30.0)
                
                //player2 cards
                HStack(){
                    if self.finalplayer2[0] == 0 && self.flipCardplayer2[0] != 0{
                        Image("back")
                            .resizable()
                            .frame(width: 100.0, height: 150.0)
                    }
                    else if self.finalplayer2[0] == 0 && self.flipCardplayer2[0] == 0{
                        Image("")
                            .resizable()
                            .frame(width: 100.0, height: 150.0)
                    }
                    else{
                        Image("card" + String(finalplayer2[0]))
                            .resizable()
                            .frame(width: 100.0, height: 150.0)
                    }
                    
                    Button(action: {
                        
                    })
                    {
                        if self.finalplayer2[1] == 0 && self.flipCardplayer2[1] != 0{
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else if self.finalplayer2[1] == 0 && self.flipCardplayer2[1] == 0{
                            Image("")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else{
                            Image("card" + String(finalplayer2[1]))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                    }
                    Button(action: {
                        
                    }) {
                        if self.finalplayer2[2] == 0 && self.flipCardplayer2[2] != 0{
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else if self.finalplayer2[2] == 0 && self.flipCardplayer2[2] == 0{
                            Image("")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else{
                            Image("card" + String(finalplayer2[2]))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                    }
                }
                
                if startGame == true {
                    
                    Button(action: {
                        //to take all the pile to your hand
                        takePile()
                    }) {
                        if self.pile == 0 {
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                                .padding(.top, 70)
                            
                        } else {
                            Image("card" + String(pile))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                                .padding(.top, 70)
                            
                            
                        }
                    }
                } else {
                    Button(action: {
                        startGame = true
                        //self.arrow = "arrow.down"
                        self.pack.shuffle()
                        //print(pack)
                        for i in 0...5{
                            self.player1[i] = self.pack[i]
                            self.pack[i] = 0
                            self.player2[i] = self.pack[i+6]
                            self.pack[i+6] = 0
                        }
                        //print(pack)
                        pack = pack.filter { $0 != 0 }
                        for i in 0...2{
                            self.flipCardplayer1[i] = self.pack[i]
                            self.pack[i] = 0
                            self.flipCardplayer2[i] = self.pack[i+3]
                            self.pack[i+3] = 0
                        }
                        pack = pack.filter { $0 != 0 }
                        //print(pack)
                        packCounter = pack.count
                        
                        //print(player1)
                        player1 = player1.sorted()
                        //print(player1)
                    }) {
                        Image("dealbutton")
                            .resizable()
                            .frame(width: 200.0, height: 120.0)
                            .padding(.top, 70)
                    }
                }
                
                
                Spacer()
                //final card player1
                HStack(){
                    Button(action: {
                        print("WORKS1")
                        if self.packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[0] != 0{
                            
                            self.player1[0] = finalplayer1[0]
                            
                            turnSucc = player1Trun(i: 0)
                            finalplayer1[0] = 0
                            if turnSucc != true{
                                takePile()
                            }
                        }
                        else if self.packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[0] == 0{
                            if (pile <= flipCardplayer1[0] && pile != 7) || (flipCardplayer1[0] == 2) || (flipCardplayer1[0] == 3) || (flipCardplayer1[0] == 10 || (pile == 7 && pile >= flipCardplayer1[0])){
                                tmpPile = pile
                                pile = flipCardplayer1[0]
                                flipCardplayer1[0] = 0
                                for i in 0...MAXCARDS{
                                    if pileArray[i] == 0 {
                                        pileArray[i] = pile
                                        if pile == 3{
                                            pile = tmpPile
                                        }
                                        break
                                    }
                                }
                            }else{
                                for i in 0...MAXCARDS{
                                    if player1[i] == 0 {
                                        player1[i] = flipCardplayer1[0]
                                        flipCardplayer1[0] = 0
                                        takePile()
                                        
                                        break
                                    }
                                }
                            }
                        }
                        if flipCardplayer1[0] == 0 && flipCardplayer1[1] == 0 && flipCardplayer1[2] == 0 {
                            arrow = "player1win"
                        } else {
                            arrow = "up"
                        }
                    }) {
                        
                        if self.finalplayer1[0] == 0 && self.flipCardplayer1[0] != 0{
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else if self.finalplayer1[0] == 0 && self.flipCardplayer1[0] == 0{
                            Image("")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else{
                            Image("card" + String(finalplayer1[0]))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        
                        
                    }
                    
                    Button(action: {
                        print("WORKS2")
                        print(flipCardplayer1[1])
                        print(packCounter)
                        print(checkHand(x: 1))
                        if packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[1] != 0{
                            
                            self.player1[0] = finalplayer1[1]
                            
                            turnSucc = player1Trun(i: 0)
                            finalplayer1[1] = 0
                            if turnSucc != true{
                                takePile()
                            }
                        } else if self.packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[1] == 0{
                            if (pile <= flipCardplayer1[1] && pile != 7) || (flipCardplayer1[1] == 2) || (flipCardplayer1[1] == 3) || (flipCardplayer1[1] == 10 || (pile == 7 && pile >= flipCardplayer1[1])){
                                tmpPile = pile
                                pile = flipCardplayer1[1]
                                flipCardplayer1[1] = 0
                                for i in 0...MAXCARDS{
                                    if pileArray[i] == 0 {
                                        pileArray[i] = pile
                                        if pile == 3{
                                            pile = tmpPile
                                        }
                                        break
                                    }
                                    
                                }
                            }
                            else{
                                for i in 0...MAXCARDS{
                                    if player1[i] == 0 {
                                        player1[i] = flipCardplayer1[1]
                                        flipCardplayer1[1] = 0
                                        takePile()
                                        break
                                    }
                                }
                            }
                            
                            if flipCardplayer1[0] == 0 && flipCardplayer1[1] == 0 && flipCardplayer1[2] == 0 {
                                arrow = "player1win"
                            } else {
                                arrow = "up"
                            }
                        }
                    }) {
                        if self.finalplayer1[1] == 0 && self.flipCardplayer1[1] != 0{
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else if self.finalplayer1[1] == 0 && self.flipCardplayer1[1] == 0{
                            Image("")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else{
                            Image("card" + String(finalplayer1[1]))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        
                        
                    }
                    Button(action: {
                        print(flipCardplayer1[2])
                        if packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[2] != 0{
                            
                            self.player1[0] = finalplayer1[2]
                            
                            turnSucc = player1Trun(i: 0)
                            finalplayer1[2] = 0
                            if turnSucc != true{
                                takePile()
                            }
                        } else if self.packCounter == 0 && checkHand(x: 1) == 0 && self.finalplayer1[2] == 0{
                            if (pile <= flipCardplayer1[2] && pile != 7) || (flipCardplayer1[2] == 2) || (flipCardplayer1[2] == 3) || (flipCardplayer1[2] == 10 || (pile == 7 && pile >= flipCardplayer1[2])){
                                tmpPile = pile
                                pile = flipCardplayer1[2]
                                flipCardplayer1[2] = 0
                                for i in 0...MAXCARDS{
                                    if pileArray[i] == 0 {
                                        pileArray[i] = pile
                                        if pile == 3{
                                            pile = tmpPile
                                        }
                                        break
                                    }
                                }
                                
                            }else{
                                for i in 0...MAXCARDS{
                                    if player1[i] == 0 {
                                        player1[i] = flipCardplayer1[2]
                                        flipCardplayer1[2] = 0
                                        takePile()
                                        break
                                    }
                                }
                            }
                        }
                        if flipCardplayer1[0] == 0 && flipCardplayer1[1] == 0 && flipCardplayer1[2] == 0 {
                            arrow = "player1win"
                        } else {
                            arrow = "up"
                        }
                    }) {
                        if self.finalplayer1[2] == 0 && self.flipCardplayer1[2] != 0 {
                            Image("back")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else if self.finalplayer1[2] == 0 && self.flipCardplayer1[2] == 0{
                            Image("")
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        else{
                            Image("card" + String(finalplayer1[2]))
                                .resizable()
                                .frame(width: 100.0, height: 150.0)
                        }
                        
                    }
                }
                ScrollView(.horizontal) {
                    //player1 hands card
                    HStack(){
                        ForEach(0 ..< 53){ i in
                            if self.player1[i] != 0 {
                                
                                Button(action: {
                                    //for start game
                                    if self.prevGame == true {
                                        if self.finalplayer1[0] == 0 {
                                            self.finalplayer1[0] = self.player1[i]
                                            self.player1[i] = 0
                                        } else {
                                            if self.finalplayer1[1] == 0 {
                                                self.finalplayer1[1] = self.player1[i]
                                                self.player1[i] = 0
                                            } else {
                                                if self.finalplayer1[2] == 0 {
                                                    self.finalplayer1[2] = self.player1[i]
                                                    self.player1[i] = 0
                                                    self.prevGame = false
                                                    
                                                    //player2 put is finals
                                                    finalplayer2[0] = player2[0]
                                                    finalplayer2[1] = player2[1]
                                                    finalplayer2[2] = player2[2]
                                                    player2[0] = 0; player2[1] = 0; player2[2] = 0
                                                    
                                                }
                                            }
                                        }
                                        
                                    } else {
                                        
                                        if arrow == "down" {
                                            player1Trun(i: i)
                                        }
                                        //player2Trun()
                                        
                                    }
                                    
                                }) {
                                    //cards in hand
                                    Image("card" + String(player1[i]))
                                        .resizable()
                                        .frame(width: 100.0, height: 150.0)
                                        .draggable("card" + String(player1[i]))
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                }
            
                .padding(60)
            }
            }
        }
    

    
    private func player2Trun() async throws -> String{
        //        ---------------------------------------------------------------------------------------------------------------------------------------------------------
        //        player2 playing
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 sec
        player2 = player2.sorted()
        if (player2[MAXCARDS-1] == 0){
            player2Empty = true
        }
        else {
            player2Empty = false
        }
        print("player2: ")
        print(player2)
        print(player2[MAXCARDS-1])
        if player2Empty != true {
            for j in 0...MAXCARDS-1{
                if self.player2[j] != 0 {
                    if (pile <= self.player2[j] && pile != 7) || (self.player2[j] == 2) || (self.player2[j] == 3) || (self.player2[j] == 10 || (pile == 7 && pile >= self.player2[j])){
                        tmpPile = pile
                        pile = self.player2[j]
                        
                        
                        //remove from player2 the card and all duplicate
                        duplicate = self.player2[j]
                        countDupl = 0
                        for k in 0...MAXCARDS-1 {
                            if duplicate == player2[k] {
                                player2[k] = 0
                                countDupl = countDupl + 1
                                cardsInHand2 = cardsInHand2 - 1
                            }
                        }
                        print("duplicate: " + String(duplicate) + " countDupl: " + String(countDupl))
                        specialCard = spicalCards(spiCard: duplicate)
                        
                        //insert card to the pileArray and all duplicates
                        for k in 0...countDupl-1 {
                            for l in 0...MAXCARDS{
                                if pileArray[l] == 0 {
                                    pileArray[l] = pile
                                    if pile == 3{
                                        pile = tmpPile
                                    }
                                    break
                                }
                                
                            }
                        }
                        print(pileArray)
                        
                        if packCounter > 0 {
                            print("player 2 hand before check")
                            print(player2)
                            cardsInHand2 = checkHand(x: 2)
                            print("card in hand = " + String(cardsInHand2))
                            while cardsInHand2 < 3 && packCounter != 0{
                                for k in 0...MAXCARDS{
                                    if self.pack[k] != 0 {
                                        for l in 0...MAXCARDS{
                                            if self.player2[l] == 0{
                                                self.player2[l] = self.pack[k]
                                                self.pack[k] = 0
                                                packCounter -= 1
                                                cardsInHand2 = cardsInHand2 + 1
                                                break
                                            }
                                        }
                                        break
                                    }
                                }
                            }
                        }
                        //remove all unnessery 0
                        pack = pack.filter { $0 != 0 }
                        //update the counter of pack
                        packCounter = pack.count
                        player2 = player2.sorted()
                        print(player2)
                        if pile != 8 || specialCard != 10{
                            return "down"
                        } else {
                            specialCard = 0
                            return "up"
                        }
                    }
                    
                    
                    
                }
                //player2 dosn't have card to put
                if j == MAXCARDS-1 {
                    
                    takePilePlayer2()
//                    pile = 0
//                    for i in 0...MAXCARDS-1 {
//                        if self.pileArray[i] != 0 {
//                            for l in 0...MAXCARDS{
//                                if self.player2[l] == 0{
//                                    self.player2[l] = self.pileArray[i]
//                                    self.pileArray[i] = 0
//                                    break
//                                }
//                            }
//                        }
//                    }
//                    //print(player1)
//                    player2 = player2.sorted()
//                    if specialCard != 8{
//                        arrow = "down"
//                    }
//                    print("player2 after taking all card!")
//                    print(player2)
//                    return "down"
                    
                }
            }
            //player2 start playing with is final
        } else if finalplayer2[2] != 0{
            if finalplayer2[0] != 0 {
                if (finalplayer2[0] > pile && pile != 7) || (finalplayer2[0] == 2) || (finalplayer2[0] == 3) || (finalplayer2[0] == 10) || (pile == 7 && pile >= finalplayer2[0]){
                    tmpPile = pile
                    pile = finalplayer2[0]
                    finalplayer2[0] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    return "down"
                }
                //need to take pile
                else {
                    player2[0] = finalplayer2[0]
                    finalplayer2[0] = 0
                    takePilePlayer2()
                    return "down"
                }
            }
            if finalplayer2[1] != 0{
                if (finalplayer2[1] > pile && pile != 7) || (finalplayer2[1] == 2) || (finalplayer2[1] == 3) || (finalplayer2[1] == 10) || (pile == 7 && pile >= finalplayer2[1]){
                    tmpPile = pile
                    pile = finalplayer2[1]
                    finalplayer2[1] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    return "down"
                }else{
                    player2[0] = finalplayer2[1]
                    finalplayer2[1] = 0
                    takePilePlayer2()
                    return "down"
                }
            }
            if finalplayer2[2] != 0{
                if (finalplayer2[2] > pile && pile != 7) || (finalplayer2[2] == 2) || (finalplayer2[2] == 3) || (finalplayer2[2] == 10) || (pile == 7 && pile >= finalplayer2[2]){
                    tmpPile = pile
                    pile = finalplayer2[2]
                    finalplayer2[2] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    player2FinalEmpty = true
                    return "down"
                }else{
                    player2[0] = finalplayer2[1]
                    finalplayer2[1] = 0
                    takePilePlayer2()
                    player2FinalEmpty = true
                    return "down"
                }
                
            }
            
        }
        //player2 play with is flip cards
        else if player2FinalEmpty == true && checkHand(x: 2) == 0{
            if flipCardplayer2[0] != 0{
                if (flipCardplayer2[0] > pile && pile != 7) || (flipCardplayer2[0] == 2) || (flipCardplayer2[0] == 3) || (flipCardplayer2[0] == 10) || (pile == 7 && pile >= flipCardplayer2[0]){
                    tmpPile = pile
                    pile = flipCardplayer2[0]
                    flipCardplayer2[0] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    
                } else {
                        //player2 dosn't have card to put
                        player2[0] = flipCardplayer2[0]
                    flipCardplayer2[0] = 0
                        pile = 0
                        for i in 1...MAXCARDS-1 {
                            if self.pileArray[i] != 0 {
                                for l in 0...MAXCARDS{
                                    if self.player2[l] == 0{
                                        self.player2[l] = self.pileArray[i]
                                        self.pileArray[i] = 0
                                        break
                                    }
                                }
                            }
                        }
                        //print(player1)
                        player2 = player2.sorted()
                        if specialCard != 8{
                            arrow = "down"
                        }
                        print("player2 after taking all card!")
                        print(player2)
                        return "down"
                }
                return "down"
            } else if flipCardplayer2[1] != 0{
                if (flipCardplayer2[1] > pile && pile != 7) || (flipCardplayer2[1] == 2) || (flipCardplayer2[1] == 3) || (flipCardplayer2[1] == 10) || (pile == 7 && pile >= flipCardplayer2[1]){
                    tmpPile = pile
                    pile = flipCardplayer2[1]
                    flipCardplayer2[1] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    
                } else {
                    //player2 dosn't have card to put
                    player2[0] = flipCardplayer2[1]
                    flipCardplayer2[1] = 0
                    pile = 0
                    for i in 1...MAXCARDS-1 {
                        if self.pileArray[i] != 0 {
                            for l in 0...MAXCARDS{
                                if self.player2[l] == 0{
                                    self.player2[l] = self.pileArray[i]
                                    self.pileArray[i] = 0
                                    break
                                }
                            }
                        }
                    }
                    //print(player1)
                    player2 = player2.sorted()
                    if specialCard != 8{
                        arrow = "down"
                    }
                    print("player2 after taking all card!")
                    print(player2)
                    return "down"
                }
                return "down"
                
            } else if flipCardplayer2[2] != 0{
                if (flipCardplayer2[2] > pile && pile != 7) || (flipCardplayer2[2] == 2) || (flipCardplayer2[2] == 3) || (flipCardplayer2[2] == 10) || (pile == 7 && pile >= flipCardplayer2[2]){
                    tmpPile = pile
                    pile = flipCardplayer2[2]
                    flipCardplayer2[2] = 0
                    for l in 0...MAXCARDS{
                        if pileArray[l] == 0 {
                            pileArray[l] = pile
                            if pile == 3{
                                pile = tmpPile
                            }
                            break
                        }
                        
                    }
                    return "player2win"
                } else{
                    //player2 dosn't have card to put
                    player2[0] = flipCardplayer2[2]
                    flipCardplayer2[2] = 0
                    pile = 0
                    for i in 1...MAXCARDS-1 {
                        if self.pileArray[i] != 0 {
                            for l in 0...MAXCARDS{
                                if self.player2[l] == 0{
                                    self.player2[l] = self.pileArray[i]
                                    self.pileArray[i] = 0
                                    break
                                }
                            }
                        }
                    }
                    //print(player1)
                    player2 = player2.sorted()
                    if specialCard != 8{
                        arrow = "down"
                    }
                    print("player2 after taking all card!")
                    print(player2)
                    return "down"
                }
            }
            
        }
        return "down"
    }
    
    private func player1Trun(i: Int) -> Bool{
        //player1 = player1.sorted()
        print("player1: ")
        print(player1)
        print (player1[i])
        //for the reset of the game
        if (pile <= self.player1[i] && pile != 7) || (self.player1[i] == 2) || (self.player1[i] == 3) || (self.player1[i] == 10 || (pile == 7 && pile >= self.player1[i])){
            tmpPile = pile
            pile = self.player1[i]
            
            //remove from player1 the card and all duplicate
            duplicate = self.player1[i]
            countDupl = 0
            for j in 0...MAXCARDS-1 {
                if duplicate == player1[j] {
                    player1[j] = 0
                    countDupl = countDupl + 1
                    cardsInHand = cardsInHand - 1
                }
            }
            
            specialCard = spicalCards(spiCard: duplicate)
            print("duplicate: " + String(duplicate) + " countDupl: " + String(countDupl) + "spical card: " + String(specialCard))
            
            //insert card to the pileArray and all duplicates
                for k in 0...countDupl-1 {
                        for j in 0...MAXCARDS{
                            if pileArray[j] == 0 {
                                pileArray[j] = pile
                                if specialCard == 3 {
                                    pile = tmpPile
                                }
                                break
                    }
                    
                }
            }
            
            print("pileArray:")
            print(pileArray)
            //taking new card from pack
            if packCounter > 0 {
                print("player 1 hand before check")
                print(player1)
                cardsInHand = checkHand(x: 1)
                print("card in hand = " + String(cardsInHand))
                while cardsInHand < 3 && packCounter != 0{
                    for j in 0...MAXCARDS{
                        if self.pack[j] != 0 {
                            for k in 0...MAXCARDS{
                                if self.player1[k] == 0{
                                    self.player1[k] = self.pack[j]
                                    self.pack[j] = 0
                                    packCounter -= 1
                                    cardsInHand = cardsInHand + 1
                                    break
                                }
                            }
                            break
                        }
                    }
                }
            }
            //remove all unnessery 0
            pack = pack.filter { $0 != 0 }
            //update the counter of pack
            packCounter = pack.count
            player1 = player1.sorted()
            if specialCard != 8{
                if  specialCard != 10{
                    self.arrow = "up"
                }
                specialCard = 0
            }
            
            print("new hand player1:")
            print(player1)
            return true
        }
        return false
        }
    
    private func takePile(){
        pile = 0
        for i in 0...MAXCARDS-1 {
            if self.pileArray[i] != 0 {
                for j in 0...MAXCARDS{
                    if self.player1[j] == 0{
                        self.player1[j] = self.pileArray[i]
                        self.pileArray[i] = 0
                        break
                    }
                }
            }
        }
        self.arrow = "up"
        //print(player1)
        player1 = player1.sorted()
        //print(player1)
    }
    
    private func takePilePlayer2(){
        //player2 dosn't have card to put
        player2[0] = flipCardplayer2[1]
        flipCardplayer2[1] = 0
        pile = 0
        for i in 1...MAXCARDS-1 {
            if self.pileArray[i] != 0 {
                for l in 0...MAXCARDS{
                    if self.player2[l] == 0{
                        self.player2[l] = self.pileArray[i]
                        self.pileArray[i] = 0
                        break
                    }
                }
            }
        }
        //print(player1)
        player2 = player2.sorted()
        if specialCard != 8{
            arrow = "down"
        }
        print("player2 after taking all card!")
        print(player2)
    }
    
    
    private func spicalCards(spiCard: Int) -> Int{
        
        switch(spiCard){
            
        case 2:
            self.pile = 2
            return 2
        case 3:
            
            return 3
        case 7:
            
            return 7
        case 8:
            return 8
            
        case 10:
            pileArray = pileArray.map{ _ in 0 }
            pile = 0
            return 10
            
        default:
            
            return 0
        }
    }
    
    
    
    private func checkHand(x: Int) -> Int {
        var count = 0
        
        if x == 1{
            for i in 0 ..< 53{
                if player1[i] != 0 {
                    count += 1
                }
            }
        }
        else{
            for i in 0 ..< 53{
                if player2[i] != 0 {
                    count += 1
                }
            }
        }
        return count
    }
    
}



#Preview {
    ContentView()
}
