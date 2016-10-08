import Foundation
import Glibc

var c1 = Colony3(size: 20)
c1.setCellAlive(x: 4, y: 4)
c1.setCellAlive(x: 4, y: 5)
c1.setCellAlive(x: 4, y: 6)
c1.setCellAlive(x: 5, y: 5)
print(c1)
//print(c1.numberLivingCells)

for _ in 0..<9 {
  c1.evolve()
  print(c1)
}
