//
//  Computation.swift
//  movies
//
//  Created by Kyle Smith on 5/11/16.
//  Copyright © 2016 Kyle Smith. All rights reserved.
//

import Foundation

class Computation
{
    func getIndexFromTitle (title : String) -> Int {
        return titlesDictionary[title]!
    }
    func calculateCoordinates(n : Int, i : Int) -> (Int, Int){
        let π = M_PI
        let tau = 2.0 * π
        let radius = 125.0
        let theta = tau / Double(n) * Double(i)
        let x = Int(radius * cos(theta))
        let y = Int(radius * sin(theta))
        return (x, y)
    }
    let titlesDictionary = ["Inception": 1, "A Million Ways to Die in the West": 52, "Lock, Stock and Two Smoking Barrels": 28, "Running Scared": 30, "The Man with the Iron Fists": 5, "Wanted": 55, "Hoodlum": 48, "Bad Lieutenant": 56, "Walking Tall": 59, "Fast Five": 60, "The Wolverine": 22, "Memento": 23, "Pusher": 14, "Machete": 13, "Homefront": 25, "Layer Cake": 44, "16 Blocks": 17, "Cop Out": 27, "Cat Run": 35, "The Amazing Spider-Man 2": 15, "Bad Boys II": 3, "Out of the Furnace": 46, "Punisher: War Zone": 50, "The Midnight Meat Train": 7, "Kiss of the Dragon": 24, "London Boulevard": 43, "The Mechanic": 2, "MacGruber": 34, "Looper": 0, "Crank": 39, "Paid in Full": 42, "Universal Soldier: Day of Reckoning": 12, "Friday the 13th": 51, "Easy Money": 45, "The November Man": 4, "Waist Deep": 63, "Guardians of the Galaxy": 21, "Act of Valor": 32, "Alex Cross": 36, "The Protector": 47, "Saw III": 64, "Savages": 38, "Seven Psychopaths": 54, "Kick-Ass 2": 10, "Four Brothers": 57, "Die Hard: With a Vengeance": 26, "3 Days to Kill": 20, "From Paris with Love": 29, "Lockout": 19, "Kite": 8, "Drive Angry": 9, "Everly": 6, "The Raid 2": 49, "The Equalizer": 33, "Fast & Furious": 58, "Grosse Pointe Blank": 62, "The Amazing Spider-Man": 18, "Empire": 40, "Knight and Day": 16, "Max Payne": 37, "Immortals": 53, "Bad Boys": 31, "Miami Vice": 11, "Faster": 61, "John Wick": 65, "Next Day Air": 41]
}