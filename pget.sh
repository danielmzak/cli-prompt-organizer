#!/bin/bash

# Set the path to search for YAML files via ENV var or:
# PROMPT_PATH=""

# Function to extract a value from a YAML file
extract_yaml_value() {
    local yaml_file="$1"
    local property="$2"
    yq -r ".prompt.$property // \"\"" "$yaml_file"
}

# Function to copy text to the clipboard
copy_to_clipboard() {
    echo -n "$1" | xclip -selection clipboard
}

# Find all .yaml files in the specified path and create an array of "search_by: filepath"
declare -a fzf_input
while IFS=  read -r -d $'\0'; do
    search_by=$(extract_yaml_value "$REPLY" 'search_by')
    if [[ -n "$search_by" ]]; then
        fzf_input+=("$search_by: $REPLY")
    else
        echo "Warning: 'search_by' field not found in $REPLY. Skipping this file."
    fi
done < <(find "$PROMPT_PATH" -type f -name "*.yaml" -print0)

# Use fzf to select a YAML file
selected=$(printf '%s\n' "${fzf_input[@]}" | fzf)

# Check if a file was selected
if [[ -n "$selected" ]]; then
    # Extract the file path from the selected line
    selected_file=$(echo "$selected" | awk -F': ' '{print $2}')
    
    # Extract the 'text' property from the selected YAML file
    text_content=$(extract_yaml_value "$selected_file" 'text')
    
    # Copy the 'text' property to the clipboard
    copy_to_clipboard "$text_content"
    
    echo "Content of 'text' property copied to clipboard."
else
    echo "No file selected."
fi
