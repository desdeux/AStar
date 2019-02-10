import queue, math

type Grid = object
    w, h: int
    walls: seq[bool]

proc newGrid*(w, h: int): Grid =
    result = Grid()
    result.walls = newSeq[bool]()

proc setWall*(self: var Grid, x, y: int, wall: bool) =
    self.walls[y * self.w + x] = wall

proc edges*(self: var Grid, node: int): seq[Edge] =
    if self.walls[node]:
        return newSeq[Edge]()
    var edges = newSeq[Edge](8)

    var x = node mod self.w
    var y = (node / self.w).int
    for dy in -1..1:
        for dx in -1..1:
            if dx == 0 and dy == 0: continue
            var nx = x + dx
            var ny = y + dy
            if nx < 0 or ny < 0 or nx >= self.w or ny >= self.h: continue
            var index = ny * self.w + nx
            if self.walls[index]: continue
            var distance = 1.0
            if dx != 0 and dy != 0:
                distance = math.sqrt(2.0)
            var edge: Edge = Edge(dst: index, cost: distance)
            edges.add(edge)
    return edges

proc search*(self: var Grid, src, dst: int): float64 =
    var x1: float = src.float mod self.w.float
    var y1 = src / self.w
    var x2: float = dst.float mod self.w.float
    var y2 = dst / self.w
    var dx = x2 - x1
    var dy = y2 - y1

    return math.sqrt(float64(dx * dx + dy * dy))

type Result = object
    nodes: seq[int]
    cost: float64

proc createResult*(item: Item): Result =
    var cost = item.cost
    var path = newSeq[int](item.depth + 1)