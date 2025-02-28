class MyHeap:
    def __init__(self, data=None):
        if data is None:
            self.heap = []
        else:
            self.heap = data
            self.heapify()

    def __str__(self):
        return str(self.heap)

    def _parent(self, index):
        return (index - 1) // 2

    def swap(self, smallest, index):
        self.heap[smallest], self.heap[index] = self.heap[index], self.heap[smallest]

    def min_heap(self, index):
        left = 2 * index + 1
        right = 2 * index + 2
        smallest = index

        if left < len(self.heap) and self.heap[left] < self.heap[smallest]:
            smallest = left
        if right < len(self.heap) and self.heap[right] < self.heap[smallest]:
            smallest = right

        if smallest != index:
            self.swap(smallest, index)
            self.min_heap(smallest)

    def heapPop(self):
        item = self.heap[0]
        self.heap[0] = self.heap.pop()
        self.min_heap(0)  # Corrected: no assignment
        return item

    def swapUp(self, i):
        parent = self._parent(i)
        if i <= 0 or self.heap[i] >= self.heap[parent]:
            return
        self.swap(i, parent)
        self.swapUp(parent)

    def heapPush(self, item):
        self.heap.append(item)
        self.swapUp(len(self.heap) - 1)

    def heapify_items(self, index):
        if index < 0:
            return
        self.min_heap(index)  # Corrected: no assignment
        self.heapify_items(index - 1)

    def heapify(self):
        self.heapify_items(len(self.heap) // 2 - 1)

myHeap = MyHeap([12, 19, 7, 25, 6, 33, 2, 15, 27, 3, 41])
print(myHeap)  # [2, 3, 7, 15, 6, 33, 12, 25, 27, 19, 41]
myHeap.heapPop() # 2 [3, 6, 7, 15, 19, 33, 12, 25, 27, 41]
myHeap.heapPush(10) # [3, 6, 7, 15, 10, 33, 12, 25, 27, 41, 19]
