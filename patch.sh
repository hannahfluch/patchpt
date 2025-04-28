#!/usr/bin/env bash

JZ_OFFSET=0x368dacc
PT_FILE=$1

EXPECTED="0f84"
PATCHED="48e9"
PATCH="\x48\xe9"

set -e

if [ -z "$PT_FILE" ]; then
    echo "Usage: $0 <PacketTracer binary file>"
    exit 1
fi

echo Checking for patch compatibility...

cd "$PT_PATH"

FOUND=$(xxd -s $JZ_OFFSET -l 2 "$PT_FILE" | awk '{print $2}')

if [ "$EXPECTED" = "$FOUND" ]; then
    echo Patching PacketTracer 8.2.2...
    echo -ne "$PATCH" | dd conv=notrunc bs=1 seek=$(("$JZ_OFFSET")) of="$PT_FILE"
	echo Patch applied successfully.
    exit 0
elif [ "$PATCHED" = "$FOUND" ]; then
    echo PacketTracer has already been patched.
    exit 0
else
    echo This PacketTracer binary is not compatible with the patch.
    exit 1
fi
