def optimizer(expressions):
    seen = {}

    for i, (target, expr) in enumerate(expressions):
        parts = expr.split()

        # If expression has operator
        if len(parts) == 3:
            a, op, b = parts

            # Constant folding
            if a.isdigit() and b.isdigit():
                expressions[i] = (target, eval(expr))

            else:
                # Same key for x+y and y+x
                key = (op, tuple(sorted([a, b])))

                if key in seen:
                    expressions[i] = (target, seen[key])
                else:
                    seen[key] = target

    return expressions


# Input
expressions = [
    ('t1', 'x + y'),
    ('t2', 'y + x'),
    ('t3', '8 + 5'),
    ('t4', 'x + z'),
    ('t5', '6 - 3'),
    ('t6', '5 * 3')
]

# Run
result = optimizer(expressions)

# Output
for x, y in result:
    print(x, "=", y)
