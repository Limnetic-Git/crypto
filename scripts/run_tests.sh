#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'   # no color

set -eu

project_root=$(cd "$(dirname "$0")/.." && pwd)

cd "$project_root"

failed=0

test_list_file=$(mktemp)
trap 'rm -f "$test_list_file"' EXIT INT TERM

find tests -type f -name '*.mojo' | sort > "$test_list_file"

while IFS= read -r test_file; do
	[ -n "$test_file" ] || continue
	echo "Running $test_file"
	if ! mojo run -I src "$test_file"; then
		failed=1
	fi
done < "$test_list_file"

if [ "$failed" -eq 0 ]; then
	printf "🚀 All tests ${GREEN}passed!${NC}"
fi

if [ "$failed" -eq 1 ]; then
	printf "💥 Some tests ${RED}failed!${NC}"
fi

exit "$failed"

