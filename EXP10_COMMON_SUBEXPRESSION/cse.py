def optimizer(expressions):
    value_table = {}

    for i, (target, expr) in enumerate(expressions):
        if ' ' in expr:
            L, op, R = expr.split(' ')

            if L.isdigit() and R.isdigit():
                # Constant expression evaluation
                if op == '+':
                    expressions[i] = (target, int(L) + int(R))
                elif op == '-':
                    expressions[i] = (target, int(L) - int(R))
                elif op == '*':
                    expressions[i] = (target, int(L) * int(R))
                elif op == '/':
                    expressions[i] = (target, int(L) // int(R))

            else:
                # Handle variables (subexpression reuse)
                L_value = value_table.get(L, ord(L))
                R_value = value_table.get(R, ord(R))

                # Create hash_key to detect common subexpressions
                hash_key = (op, min(L_value, R_value), max(L_value, R_value))

                if hash_key in value_table:
                    # Replace with previously computed variable (e.g., t2 = t1)
                    expressions[i] = (target, expressions[value_table[hash_key]][0])
                else:
                    value_table[hash_key] = i

        # Update variable lookup table
        value_table[target] = i

    return expressions


# Input expressions
expressions = [
    ('t1', 'x + y'),
    ('t2', 'y + x'),
    ('t3', '8 + 5'),
    ('t4', 'x + z'),
    ('t5', '6 - 3'),
    ('t5', '5 * 3'),
]

# Run optimizer
ans = optimizer(expressions)

# Print results
for target, expr in ans:
    print(f"{target} = {expr}")
