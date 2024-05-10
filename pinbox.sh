#!/bin/bash

# Get the current date/time
current_date=$(date +"%Y-%m-%d-%H-%M-%S")

# Set the save path via ENV var or:
# PROMPT_INBOX_PATH=""

# Get the clipboard content
clipboard_content=$(xclip -selection clipboard -o)

# Generate a UUID
uuid=$(uuidgen)

# Create the YAML file using a heredoc
cat > "$PROMPT_INBOX_PATH/prompt-inbox-$current_date.yaml" <<EOF
---
prompt:
  uuid: $uuid
  text: |-
$(echo "$clipboard_content" | sed 's/^/    /')
  search_by:
  description:
  tags:
  created_by: me
  created_at: $current_date
EOF

echo "YAML file created at $PROMPT_INBOX_PATH/prompt-inbox-$current_date.yaml"
