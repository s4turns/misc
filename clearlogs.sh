#!/bin/bash

# Clear logs
truncate /var/log/* --size 0
rm -rf /var/log/*.gz
rm -rf /var/log/*.1

echo You are clear gangsta.
