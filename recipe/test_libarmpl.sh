#!/usr/bin/env bash
# Run the tests for libarmpl

set -ex

exists() {
	FULL_PATH="${PREFIX}/${1}"
	if [ -f "${FULL_PATH}" ]; then
		echo "Found ${1}"
	else
		echo "Could not find ${FULL_PATH}"
		exit 1
	fi
}

for i in lib/{libarmpl{,_mp,_int64_mp,_int64},libamath,libastring}.so; do
	exists $i
done
