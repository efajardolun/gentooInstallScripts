#!/bin/bash
date -s "$(curl -H'Cache-Control:no-cache' -sI google.com | grep '^Date:' | cut -d' ' -f3-6)Z"
