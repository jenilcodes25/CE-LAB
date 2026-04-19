n = int(input("Enter number of operations: "))

graph = []
for i in range(n):
    row = list(map(int, input().split()))
    graph.append(row)

delay = list(map(int, input("Enter delay of each operation:\n").split()))

indegree = [0]*n
done = [False]*n
finish = [0]*n
active = []

for j in range(n):
    for i in range(n):
        if graph[i][j]:
            indegree[j]+=1

cycle = 1
completed = 0

print("\nScheduling Order:\n")

while completed < n:

    # remove finished ops
    new_active = []
    for op in active:
        if finish[op] <= cycle:
            done[op] = True
            completed += 1
            for j in range(n):
                if graph[op][j]:
                    indegree[j]-=1
        else:
            new_active.append(op)

    active = new_active

    ready = []

    for i in range(n):
        if indegree[i]==0 and not done[i] and i not in active:
            ready.append(i)

    if ready:
        print("Cycle",cycle,":",end=" ")
        for op in ready:
            print(f"OP{op+1} scheduled",end="   ")
            finish[op] = cycle + delay[op]
            active.append(op)
        print()
    else:
        print(f"Cycle {cycle} : Stall")

    cycle += 1