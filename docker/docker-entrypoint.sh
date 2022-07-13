#!/bin/bash
# More safety, by turning some bugs into errors.
# Without `errexit` you don’t need ! and can replace
# PIPESTATUS with a simple $?, but I don’t do that.
set -o errexit -o pipefail -o noclobber -o nounset

echo "[ENTRYPOINT] Entrypoint script for the module."

: "${MODULE_NAME:?Need to set MODULE_NAME environment variable to string}"
: "${MODULE_TYPE:?Need to set MODULE_TYPE environment variable to string (Input, Processing, Output)}"

# Validate the environment according to module type
if [[ "$MODULE_TYPE" == "Input" ]]
then
    : "${EGRESS_URLS:?Need to set EGRESS_URLS environment variable to string}"
elif [[ "$MODULE_TYPE" == "Processing" ]]
then
    : "${HOST_NAME:?Need to set HOST_NAME environment variable to string}"
    : "${HOST_PORT:?Need to set HOST_PORT environment variable to string}"
    : "${EGRESS_URLS:?Need to set EGRESS_URLS environment variable to string}"
elif [[ "$MODULE_TYPE" == "Output" ]]
then
    : "${HOST_NAME:?Need to set HOST_NAME environment variable to string}"
    : "${HOST_PORT:?Need to set HOST_PORT environment variable to string}"
else
    echo "Unrecognized MODULE_TYPE = $MODULE_TYPE, choose from Input, Processing, Output"
    exit 1
fi
echo "[ENTRYPOINT] Environment validated."

# CALL THE MAIN SCRIPT
python /app/src/main.py
