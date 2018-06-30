import Foundation
import Dispatch
// http://patorjk.com/software/taag/#p=testall&f=ANSI%20Shadow&t=SAiDoku
print("""

███████╗ █████╗ ██╗██████╗  ██████╗ ██╗  ██╗██╗   ██╗
██╔════╝██╔══██╗██║██╔══██╗██╔═══██╗██║ ██╔╝██║   ██║
███████╗███████║██║██║  ██║██║   ██║█████╔╝ ██║   ██║
╚════██║██╔══██║██║██║  ██║██║   ██║██╔═██╗ ██║   ██║
███████║██║  ██║██║██████╔╝╚██████╔╝██║  ██╗╚██████╔╝
╚══════╝╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝

""")
/*
let filePath = CommandLine.arguments[1]
guard let gameString = try? String(contentsOfFile: filePath) else
{
    print("BAD FILE")
    exit(1)
}*/
let gameString = "...16..2...2...8.5..5..36.9....5.18...........96.7....1.89..3..4.9...7...5..16..."

// set this to true to see the board at each step
let LIVE_DEBUG_PRINT_STEPS = false;

let game = SudokuGame(gameString)

// Use DispatchGroup to pause exit until finished
let group = DispatchGroup()
group.enter()

// time execution
let start = DispatchTime.now()

game.solve({ result in
    
    DispatchQueue.main.async(execute: group.leave)

    print("Solution:");
    print(result.description);
    
    let end = DispatchTime.now()
    
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000
    
    print("That took \(timeInterval) seconds to solve.")
    
    exit(0);
})

group.wait()

