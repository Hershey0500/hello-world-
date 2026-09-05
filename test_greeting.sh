#!/bin/bash

# Define the path to the greeting script
greeting_script="./2-greeting.sh"

# Define an array of names
names=("John" "Alice" "Michael")

# Loop through each name and run the greeting script with input redirection
for name in "${names[@]}"; do
  output=$(echo "$name" | bash "$greeting_script")
  expected_output="Hello, $name! Welcome to the world of bash scripting."

  # Compare the actual output with the expected output
  if [[ "$output" == "$expected_output" ]]; then
    echo "Test Passed: Output is correct for $name"
  else
    echo "Test Failed: Output is incorrect for $name"
    echo "Expected: $expected_output"
    echo "Actual: $output"
    exit 1
  fi
done
