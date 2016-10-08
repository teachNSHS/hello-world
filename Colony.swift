struct Cell : Hashable, CustomStringConvertible {
  let x: Int
  let y: Int

  init(x: Int, y: Int){
    self.x = x
    self.y = y
  }

  var description : String{
    return "X: \(x), y: \(y)"
  }

  public static func ==(lhs:Cell, rhs:Cell) -> Bool {
    return (lhs.x == rhs.x) && (rhs.y == lhs.y)
  }

  var hashValue: Int {
        return x * 1000 + y
    }
}


class Colony : CustomStringConvertible{
  var cells = Set<Cell>()
  var allCellsToCheck = Set<Cell>()
  var generationNumber = 0
  var size: Int

  init(size: Int){self.size = size}

  func setCellAlive(x: Int, y: Int){
    cells.insert(Cell(x: x, y: y))
  }

  func setCellDead(x: Int, y: Int){
    cells.remove(Cell(x: x, y: y))
  }

  func isCellAlive(c: Cell)->Bool{
    return cells.contains(c)
  }

  func setCellsToCheck(c: Cell){
    let x = c.x
    let y = c.y
    allCellsToCheck.insert(Cell(x: x - 1, y: y - 1))
    allCellsToCheck.insert(Cell(x: x, y: y - 1))
    allCellsToCheck.insert(Cell(x: x + 1, y: y - 1))
    allCellsToCheck.insert(Cell(x: x - 1, y: y ))
    allCellsToCheck.insert(Cell(x: x + 1, y: y ))
    allCellsToCheck.insert(Cell(x: x , y: y ))
    allCellsToCheck.insert(Cell(x: x - 1, y: y + 1))
    allCellsToCheck.insert(Cell(x: x, y: y + 1 ))
    allCellsToCheck.insert(Cell(x: x + 1, y: y + 1))
  }

  func countCell(x: Int, y: Int)->Int {
    if cells.contains(Cell(x: x, y: y)){return 1}
    return 0
  }

  func countNeighbours(c: Cell)->Int{
    let x = c.x
    let y = c.y
    var sum = 0
    sum += countCell(x: x - 1, y: y - 1)
    sum += countCell(x: x , y: y - 1)
    sum += countCell(x: x + 1, y: y - 1)
    sum += countCell(x: x - 1, y: y )
    sum += countCell(x: x + 1, y: y )
    sum += countCell(x: x - 1, y: y + 1)
    sum += countCell(x: x , y: y + 1)
    sum += countCell(x: x + 1, y: y + 1)
    return sum
  }

  func setAllCellsToCheck(){
    allCellsToCheck = Set<Cell>()
    for c in cells {
      setCellsToCheck(c: c)
    }
  }

func aliveNextGen(c: Cell, livingNeighbours: Int)->Bool{
  if (livingNeighbours == 3){return true}
  if (livingNeighbours < 2) || (livingNeighbours > 3){return false}
  return isCellAlive(c: c)
}

func evolve(){
  generationNumber += 1
  var newCells = Set<Cell>()
  setAllCellsToCheck()
  for c in allCellsToCheck {
    if aliveNextGen(c: c, livingNeighbours: countNeighbours(c: c)) {
      newCells.insert(c)
    }

  }
cells = newCells

}
  var description: String {
    var result = "Generation # \(generationNumber)\n"
    for x in 0..<size{
      for y in 0..<size {
        if isCellAlive(c: Cell(x: x, y: y)) {
          result += "*"
        } else {
          result += " "
        }

      }
      result += "\n"
    }
    return result
  }
}
