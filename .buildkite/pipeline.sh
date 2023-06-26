#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eu

# Get value from input
NUMBER_OF_AGENTS=$(buildkite-agent meta-data get agent-number)

# begin the pipeline.yml file
echo | cat << EOF
steps:
  - group: "Parallel steps"
    key: parallel-steps
    steps: 
      - label: ":console:"
        command: "script.sh"
        parallelism: ${NUMBER_OF_AGENTS}
        agents:
          queue: "${BUILDKITE_AGENT_META_DATA_QUEUE:-default}"
  - label: ":rocket: Deploy"
    command: |
      echo "Deploying!"
      buildkite-agent annotate 'Successful deploy! ✨' --style "success"
    if: build.branch == "main"
    depends_on: "parallel-steps"