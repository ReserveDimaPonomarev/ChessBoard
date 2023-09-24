//
//  ViewController.swift
//  test
//
//  Created by Дмитрий Пономарев on 09.03.2023.
//

import UIKit

enum Figure {
    case Pawn (color: Color, position: String)
    case King (color: Color, position: String)
    
    enum Color {
        case White
        case Black
    }
}

extension Figure: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "King1": self = .King(color: .Black, position: "c3")
        case "King2": self = .King(color: .White, position: "b3")
        case "Pawn1": self = .Pawn(color: .White, position: "c2")
        default:
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .King: return "King"
        case .Pawn: return "Pawn"
        }
    }
}

//    MARK: - ViewController

class ViewController: UIViewController {
    
    var dict : [String: Character] = [:]
    var readyArray = [Figure]()
    var baseArray = [String]()
    var blackArray: [String] = []
    var whiteArray: [String] = []
    
    //    MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeChessBoard()
        addFiguresInArray(array: &readyArray)
        //        getArray(array: readyArray)
        makenewValue()
        
//        definePosition(figure: .King(color: .White, position: "c3"), position: (letter: "c", number: 4))
        definePosition(figure: readyArray[2], position: (letter: "a", number: 1))
//        definePosition(figure: .Pawn(color: .Black, position: "a1"), position: (letter: "a", number: 3))
        print(dict)

    }
    
    //    MARK: - addFiguresInArray
    
    func addFiguresInArray(array: inout [Figure]) {
        let king1 = Figure.King(color: .Black, position: "c3")
        let king2 = Figure.King(color: .White, position: "b3")
        let pawn1 = Figure.Pawn(color: .White, position: "a2")
        array.append(king1)
        array.append(king2)
        array.append(pawn1)
    }
    
    //    MARK: - makeArrayChessboard
    
    func makeChessBoard() -> [String: Character] {
        let dictNum = [1, 2, 3, 4, 5, 6, 7, 8]
        let dictLetter = ["a", "b", "c", "d", "e", "f", "g", "h"]
        var a = 0

        
        for number in dictNum {
            
            if number % 2 != 0 {
                for letter in dictLetter {
                    a += 1
                    if a % 2 != 0 {
                        blackArray.append("\(letter)\(number)")
                    } else {
                        whiteArray.append("\(letter)\(number)")
                    }
                }
            } else if number % 2 == 0 {
                for letter in dictLetter {
                    a += 1
                    if a % 2 == 0 {
                        blackArray.append("\(letter)\(number)")
                    } else {
                        whiteArray.append("\(letter)\(number)")
                    }
                }
            }
            for i in blackArray {
                dict[i] = "\u{2B1B}"
            }
            for i in whiteArray {
                dict[i] = "\u{2B1C}"
            }
        }
        var baseArray1 = [String]()
        baseArray1 = blackArray + whiteArray
        baseArray = baseArray1.sorted()
        
        return dict
        
    }
    
    
    func getArray(array: [Figure]) {
        
        for value in array {
            switch value {
            case .King(let color, let position):
                print ( "\(color), \(position)")
            case .Pawn(let color, let position):
                print ("\(color), \(position)")
            }
        }
    }
    
    func printfigure(figure: Figure) -> String {
        switch figure {
        case .King(let color, let position):
            print ( "\(color), \(position)")
        case .Pawn(let color, let position):
            print ("\(color), \(position)")
        }
        return ""
    }
    
    func makenewValue() {
        var newValue: String? = nil
        for value in dict.keys {
            newValue = value
            for figure in readyArray {
                switch figure {
                case .King(let color, let position):
                    if position == newValue && color == .Black {
                        dict[newValue!] = "\u{26AA}"
                    } else if position == newValue && color == .White {
                        dict[newValue!] = "\u{26AB}"
                    }
                case .Pawn(_, let position):
                    if position == newValue {
                        dict[newValue!] = "\u{1F534}"
                    }
                }
            }
        }
    }
    
    func definePosition(figure: Figure, position:(letter: String, number: Int))  {
        
        let wantedPosition = "\(position.letter)\(position.number)"
        var new = String()
        switch figure {
        case .King(color: .White, position: let position):
            let indexOfFiguresPosition = baseArray.firstIndex(of: position)!
            let indexOfWantedPos = baseArray.firstIndex(of: wantedPosition)
            
            switch indexOfWantedPos {
            case indexOfFiguresPosition + 1:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            case indexOfFiguresPosition - 1:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            case indexOfFiguresPosition + 8:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            case indexOfFiguresPosition - 8:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            default:           print ("Change place!")
            }
            
        case .King(color: .Black, position: let position):
            let indexOfFiguresPosition = baseArray.firstIndex(of: position)!
            let indexOfWantedPos = baseArray.firstIndex(of: wantedPosition)
            
            switch indexOfWantedPos {
            case indexOfFiguresPosition + 1:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
                
            case indexOfFiguresPosition - 1:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            case indexOfFiguresPosition + 8:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            case indexOfFiguresPosition - 8:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            default:           print ("Change place!")
            }
            
        case .Pawn(_, position: let position):
            let indexOfFiguresPosition = baseArray.firstIndex(of: position)!
            let indexOfWantedPos = baseArray.firstIndex(of: wantedPosition)
            
            switch indexOfWantedPos {
            case indexOfFiguresPosition - 1:            new = (baseArray[indexOfWantedPos!]);
                divide(pos: position)
            case indexOfFiguresPosition + 2:            new = (baseArray[indexOfWantedPos!]); divide(pos: position)
            default:                                    print ("choose Place!")
            }
            
        }
        
        for value in dict.keys {
            if value == new {
                dict[value] = "\u{1F534}"
                let newdict = dict.sorted {$0.key < $1.key }
                
                for (k,v) in (Array(newdict).sorted {$0.key < $1.key}) {
                    let value = "[\(k): \(v)]"
//                    print(value)
                }
            }
        }
    }
    
    func divide(pos: String) {
        if blackArray.contains(where: {$0 == pos}) {
            dict[pos] = "\u{2B1B}"
        } else {
            dict[pos] = "\u{2B1C}"
        }
    }
}



