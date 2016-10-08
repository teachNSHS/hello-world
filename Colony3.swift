
class Colony3 : CustomStringConvertible{
  var cells = Set<Cell>()
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

  var numberLivingCells: Int {return cells.count}

  func setCellsToCheck(c: Cell)->Set<Cell>{
    let x = c.x
    let y = c.y
    var result = Set<Cell>()
    result.insert(Cell(x: x - 1, y: y - 1))
    result.insert(Cell(x: x, y: y - 1))
    result.insert(Cell(x: x + 1, y: y - 1))
    result.insert(Cell(x: x - 1, y: y ))
    result.insert(Cell(x: x + 1, y: y ))
    result.insert(Cell(x: x , y: y ))
    result.insert(Cell(x: x - 1, y: y + 1))
    result.insert(Cell(x: x, y: y + 1 ))
    result.insert(Cell(x: x + 1, y: y + 1))
    return result
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

  func isGoodCell(c: Cell)->Bool{
    return (c.x >= 0) && (c.y >= 0) && (c.x <= size) && (c.y <= size)
  }

  func aliveNextGen(c: Cell)->Bool{
    let livingNeighbours = countNeighbours(c: c)
    if (livingNeighbours == 3){return true}
      if (livingNeighbours < 2) || (livingNeighbours > 3){return false}
        return isCellAlive(c: c)
      }

      func evolve(){
        generationNumber += 1
        let newCells = cells.flatMap{setCellsToCheck(c: $0)}
        .filter{aliveNextGen(c: $0)}
        .filter{isGoodCell(c: $0)}
        cells = Set<Cell>(newCells)
      }

      var description: String {
        var result = "Generation ## \(generationNumber)\n"
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
