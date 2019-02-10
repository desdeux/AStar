type Edge* = object
    dst*: int
    cost*: float64

type Item* = ref object
    id: int
    cost: float64
    score: float64
    depth: int
    next: Item

proc newItem*(self: var Item, id: int) = self.id = id

proc follow*(self: var Item, edge: Edge, estimate: float64): Item =
    result = Item()
    result.id = edge.dst
    result.cost = self.cost + edge.cost
    result.score = result.cost + estimate
    result.depth = self.depth + 1
    result.next = self

type PriorityQueue = seq[Item]

proc len*(pq: PriorityQueue): int = pq.len

proc less*(pq: PriorityQueue, i, j: int): bool = pq[i].cost < pq[j].cost

proc swap*(pq: var PriorityQueue, i, j: int) = swap(pq[i], pq[j])

proc push*(pq: var PriorityQueue, x: Item) = pq.push(x)

proc pop*(pq: var PriorityQueue): Item =
    result = pq[len(pq) - 1]
    pq = pq[0..len(pq) - 1]