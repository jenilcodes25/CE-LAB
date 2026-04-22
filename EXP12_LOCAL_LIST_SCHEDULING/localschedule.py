# Read number of operations
n = int(input("Enter number of operations: "))

# Read dependency matrix
graph = []
for i in range(n):
    row = list(map(int, input().split()))
    graph.append(row)

# Read delay times
delay = list(map(int, input("Enter delays: ").split()))

# Find indegree
indegree = [0] * n
for j in range(n):
    for i in range(n):
        indegree[j] += graph[i][j]

done = [False] * n
finish = [0] * n
active = []

cycle = 1
completed = 0

print("\nScheduling Order:\n")

while completed < n:

    # Remove finished operations
    new_active = []
    for op in active:
        if finish[op] == cycle:
            done[op] = True
            completed += 1

            for j in range(n):
                if graph[op][j] == 1:
                    indegree[j] -= 1
        else:
            new_active.append(op)

    active = new_active

    # Find ready operations
    ready = []
    for i in range(n):
        if indegree[i] == 0 and done[i] == False and i not in active:
            ready.append(i)

    # Schedule operations
    if ready:
        print("Cycle", cycle, ":", end=" ")
        for op in ready:
            print("OP" + str(op + 1), end=" ")
            finish[op] = cycle + delay[op]
            active.append(op)
        print()
    else:
        print("Cycle", cycle, ": Stall")

    cycle += 1