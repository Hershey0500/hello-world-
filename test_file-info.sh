#!/bin/bash

# Define the path to the file_info.sh script
file_info_script="./4-file-info.sh"

# Define an array of test files to create
test_files=(
    "./test-file-1.txt"
    "./nonexistent_file.txt"
    "./test-file-2.txt"
)

# Create the test files with the specified timestamps
file="./test-file-1.txt"
created="202306220315"
modified="202306220315"

echo "Hello, World!" > "$file"

touch -t "$created" "$file"
touch -mt "$modified" "$file"

file="./test-file-2.txt"
created="202306220326"
modified="202306220326"

echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." > "$file"

touch -t "$created" "$file"
touch -mt "$modified" "$file"

# Define expected outputs for each file
expected_outputs=(
    "File: ./test-file-1.txt
Size: [0-9]+[KMG]?
Permissions: [\-rwx]+
Created: [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}
Modified: [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}"
    "Error: File './nonexistent_file.txt' does not exist."
    "File: ./test-file-2.txt
Size: [0-9]+[KMG]?
Permissions: [\-rwx]+
Created: [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}
Modified: [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}"
)

# Initialize a variable to track test failures
test_failed=0

# Perform the tests
for ((i = 0; i < ${#test_files[@]}; i++)); do
    file="${test_files[$i]}"
    expected_output="${expected_outputs[$i]}"

    echo "Testing file: $file"
    echo "---------------------"

    # Run the file_info.sh script with the current test file
    output=$(bash "$file_info_script" <<< "$file" 2>&1)
    exit_status=$?

    # Check if the exit status indicates an error
    if [[ $exit_status -ne 0 ]]; then
        echo "Test Failed: Script exited with non-zero status."
        echo "Exit Status: $exit_status"
        echo "Error Output: $output"
        test_failed=1
    # Check for known error messages in output
    elif [[ "$file" == "./nonexistent_file.txt" && "$output" == "$expected_output" ]]; then
        echo "Test Passed: Error output is correct for nonexistent file!"
    elif [[ "$file" != "./nonexistent_file.txt" && "$output" =~ File:\ [^\n]+ && "$output" =~ Size:\ [^\n]+ && "$output" =~ Permissions:\ [^\n]+ && "$output" =~ Created:\ [^\n]+ && "$output" =~ Modified:\ [^\n]+ ]]; then
        # Check if the output matches the expected pattern
        if echo "$output" | grep -Eq "$expected_output"; then
            echo "Test Passed: Output is correct!"
        else
            echo "Test Failed: Output is incorrect or incomplete."
            echo "Expected Pattern: $expected_output"
            echo "Actual Output: $output"
            test_failed=1
        fi
    else
        echo "Test Failed: Output is missing required fields or has empty fields."
        echo "Expected Pattern: $expected_output"
        echo "Actual Output: $output"
        test_failed=1
    fi

    echo "====================="
    echo
done

# Remove the test files
rm -f "${test_files[@]}"

# Exit with status 1 if any test failed
if [[ $test_failed -ne 0 ]]; then
    exit 1
fi
