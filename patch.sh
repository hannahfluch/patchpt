#!/bin/bash

JZ_OFFSET=0x368dacc
PT_FILE=$1

EXPECTED="0f84"
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

    exit
fi
echo This PacketTracer binary is not compatible with the patch.
