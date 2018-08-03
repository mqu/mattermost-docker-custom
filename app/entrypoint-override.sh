#!/bin/sh

echo "# --- $0 ---"

for f in /app/override/*enabled*.sh
do
  [ -x $f ] && $f $@
done

# run mattemost original entrypoint.sh
[ -x /entrypoint.sh ] && /entrypoint.sh $@
