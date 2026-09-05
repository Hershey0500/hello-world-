#!/bin/bash

# Define the path to the Hello World script
hello_world_script="./1-hello-world.sh"

# Run the Hello World script and capture the output
output=$("$hello_world_script")

# Define the expected output of the Hello World script
expected_output="Hello, World!"

# Compare the actual output with the expected output
if [ "$output" = "$expected_output" ]; then
  echo "Test Passed: Output is correct!"
  exit 0
else
  echo "Test Failed: Output is incorrect."
  echo "Expected: $expected_output"
  echo "Actual: $output"
  exit 1
fi
