import Foundation

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
let gameString = "984531.7261...7...257..98..3...6..1....37.92...9..5....3...6....45.18.961967..28."

let game = SudokuGame(gameString)
game.solve({ result in
    print(result.description);
    exit(0);
})
