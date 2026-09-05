#!/bin/bash

# Define the path to the calculator script
calculator_script="./3-calculator.sh"

# Define test numbers and expected outputs
test_numbers=(
  "5 3 8 2 15 1"
  "10 2 12 8 20 5"
  "7 4 11 3 28 1"
)

IFS=" "
# Initialize a variable to track test failures
test_failed=0

for ((i = 0; i < ${#test_numbers[@]}; i++)); do
  read -r num1 num2 res1 res2 res3 res4 <<<"${test_numbers[i]}"
  echo $num1 $num2 $res1 $res2 $res3 $res4

  # Run the calculator script and capture the output
  output=$(bash "$calculator_script" <<<"$num1"$'\n'"$num2")

  # Define the expected outputs
  expected_sum="The sum of $num1 and $num2 is $res1."
  expected_difference="The difference between $num1 and $num2 is $res2."
  expected_product="The product of $num1 and $num2 is $res3."
  expected_quotient="The quotient of $num1 divided by $num2 is $res4."

  # Compare the actual output with the expected output
  if [[ "$output" =~ "$expected_sum" && "$output" =~ "$expected_difference" && "$output" =~ "$expected_product" && "$output" =~ "$expected_quotient" ]]; then
    echo "Test Passed: Output is correct!"
  else
    echo "Test Failed: Output is incorrect."
    echo "Expected Sum: $expected_sum"
    echo "Expected Difference: $expected_difference"
    echo "Expected Product: $expected_product"
    echo "Expected Quotient: $expected_quotient"
    echo "Actual Output:"
    echo "$output"

    # Set the failure flag
    test_failed=1
  fi
done

# Exit with status 1 if any test failed
if [[ $test_failed -ne 0 ]]; then
  exit 1
fi
