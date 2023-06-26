#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

# Get value from input
NUMBER_OF_AGENTS=$(buildkite-agent meta-data get agent-number)

# begin the pipeline.yml file
echo | cat << EOF
steps:
  - label: ":console:"
    command: "script.sh"
    parallelism: ${NUMBER_OF_AGENTS}
    agents:
      queue: "${BUILDKITE_AGENT_META_DATA_QUEUE:-default}"