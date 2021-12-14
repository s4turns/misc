#!/bin/bash

# Clear logs
truncate /var/log/* --size 0
rm *.gz
rm *.1

echo You are clear gansta.
