#!/bin/bash

# Prompt the user to enter two numbers (ask for the first number and then the second)
read -p "Enter the first number: " x
read -p "Enter the second number: " y

# Perform arithmetic operations
sum=$((x + y))
difference=$((x - y))
product=$((x * y))

if [ "$y" -eq 0 ]; then
  quotient="undefined"
else
  quotient=$((x / y))
fi

# Display the results
echo "The sum of $x and $y is $sum."
echo "The difference between $x and $y is $difference."
echo "The product of $x and $y is $product."
echo "The quotient of $x divided by $y is $quotient."
