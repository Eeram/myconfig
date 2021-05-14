#!/usr/bin/env bash

echo "[debug] Starting caffeinate result :: $1"

RES=$(caffeinate -t "$((($1 - 1) * 60))")
>&2 echo "[debug] Caffeinate result :: ${RES}"
