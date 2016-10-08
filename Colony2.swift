class Colony2 : CustomStringConvertible{
  var generationNumber = 0
  var cells: [Int]
  var tempCells: [Int]
  var size: Int
  let liveValue = 1
  let deadValue = 0

  init(size: Int){
    self.size = size
    cells = [Int](repeating: 0, count: (size + 2) * (size + 2))
    tempCells = [Int](repeating: 0, count: (size + 2) * (size + 2))
  }

  func index(row: Int, col: Int)-> Int{
    return (row + 1) * (size + 2) + col + 1
  }

  func setCellAlive(row:Int, col: Int){
    cells[index(row: row, col: col)] = liveValue
  }

  func setTempCellState(row:Int, col: Int, state: Int){
    tempCells[index(row: row, col: col)] = state
  }


  func setCellDead(row:Int, col: Int){
    cells[index(row: row, col: col)] = deadValue
  }

  func isCellAlive(row: Int, col: Int)->Bool{
    return cells[index(row: row, col: col)] == liveValue
  }

func isAliveNextGen(livingNeighbours: Int, currentState: Int)->Int{
  if (livingNeighbours == 3) {return liveValue}
  if (livingNeighbours < 2) ||  (livingNeighbours > 3){return deadValue}
  return currentState
}



  func numberNeighbours(row: Int, col: Int)->Int{
    var sum = 0
    sum += cells[index(row: row - 1, col: col - 1)]
    sum += cells[index(row: row - 1, col: col )]
    sum += cells[index(row: row - 1, col: col + 1)]
    sum += cells[index(row: row , col: col - 1)]
    sum += cells[index(row: row , col: col + 1)]
    sum += cells[index(row: row + 1, col: col - 1)]
    sum += cells[index(row: row + 1, col: col )]
    sum += cells[index(row: row + 1, col: col + 1)]
    return sum
  }

var numberLivingCells: Int {
  return cells.reduce(0, +)
}

func evolve(){
  generationNumber += 1
  for row in 0..<size {
    for col in 0..<size {
      let livingNeighbours = numberNeighbours(row: row, col: col)
      let currentState = cells[index(row: row, col: col)]
      setTempCellState(row: row, col: col,
        state: isAliveNextGen(livingNeighbours: livingNeighbours, currentState: currentState))
    }
  }
  cells = tempCells
}

  var description: String {
    var desc = "Generation # \(generationNumber)\n"

   for row in 0..<size {
     for col in 0..<size {
       desc += isCellAlive(row: row, col: col) ? "*" : " "
     }
     desc += "\n"
   }
   return desc
  }

}
